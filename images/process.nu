export def process-img [
  img: path,
  out_path: path = 'output.png',
  --remove-bg (-r),
  --alpha-matting-foreground-threshold (-f): oneof<nothing, int> = null,
  --alpha-matting-background-threshold (-B): oneof<nothing, int> = null,
  --alpha-matting-erode-size (-e): oneof<nothing, int> = null,
  --model (-m): string@models = 'bria-rmbg' # One of the available models for rembg
  --border-scale : float = 0.02, # Border thickness in percentage
  --padding-scale : float = 0.04, # Padding in percentage
  --preview (-p) # Preview image
] {
    let no_bg = (mktemp --suffix .png)
    let alpha_bg = (mktemp --suffix .png)

    let image_info = ^magick identify $img | split column ' ' | rename 'filename' 'extension' 'size1' 'size2' 'color_channel' 'color_space' 'filesize' | first

    let size = $image_info.size1 | parse '{width}x{height}' | first | update width { $in | into int } | update height { $in | into int }
    
    if ($remove_bg) {
      let fg_flag = if $alpha_matting_foreground_threshold != null { ['-af' $alpha_matting_foreground_threshold] } else { [] }
      let bg_flag = if $alpha_matting_background_threshold != null { ['-ab' $alpha_matting_background_threshold] } else { [] }
      let erode_size = if $alpha_matting_erode_size != null { ['-ae' $alpha_matting_erode_size] } else { [] }
      ^uv tool run rembg[cpu,cli] i $img $no_bg ...$fg_flag ...$bg_flag ...$erode_size -m $model
    } else {
      ^cp $img $no_bg
    }


    let border_size = $size.height * $border_scale
    let pad = $size.height * $padding_scale

    let morph = $"disk:($border_size)" 

    # 3. Add white border & padding
    ^magick $no_bg -trim +repage -background none -bordercolor none -border $pad "(" +clone -channel A -morphology Dilate $morph +channel -fill white -colorize 100% ")" +swap -compose over -composite $alpha_bg

    cp $alpha_bg $out_path
    rm $no_bg $alpha_bg

    if $preview {
      chafa $out_path
    }
}

export def --wrapped chafa-preview [
  ...args
] {
  for sym in (symbols) {
    print $"($sym):"
    chafa -f symbol --symbols $sym --size '80x25' --bg '#00000000' ...$args
  }
}

# Define the completion function for chafa
def "nu-complete chafa" [context: string] {
    # Extract the current word being typed
    let current_word = ($context | split row ' ' | last)
    
    # List files and filter for common image extensions
    # If no images found, it will just show everything in the directory
    ls 
    | where {
      ($in.type == 'dir') 
      or ($in.type == 'file' and (($in.name | path parse | get extension) in [ 'jpg' 'jpeg' 'png' 'gif' 'webp' 'tiff' 'bmp']))
    }
    | get name
}

export extern chafa [
  --files: path                                        # Read list of files to process from PATH, or "-" for stdin.
  --files0: path                                       # Similar to --files, using NUL separator instead of newline.
  --help (-h)                                          # Show help.
  --probe: string@on-off-auto-modes                    # Probe terminal's capabilities and wait for response [auto, on, off].
                                                       # A positive real number denotes the maximum time to wait for a response, in seconds. Defaults to 5.0.
  --probe-mode: string@probe-modes                     # How to probe the terminal [any, ctty, stdio].
  --version                                            # Show version.
  --verbose (-v)                                       # Be verbose.
  --format (-f): string@formats                        # Set output format; one of [iterm, kitty, sixels, symbols]. 
                                                       # Iterm, kitty and sixels yield much higher quality but enjoy limited support. Symbols mode yields beautiful character art.
  --optimize (-O): int@optimization-modes              # Compress the output by using control sequences intelligently [0-9]. 
                                                       # 0 disables, 9 enables every available optimization. Defaults to 5, except for when used with "-c none", where it defaults to 0.
  --relative: string@on-off-modes = 'off'              # Use relative cursor positioning [on, off]. 
                                                       # When on, control sequences will be used to position images relative to the cursor.
                                                       # When off, newlines will be used to separate rows instead for e.g. 'less -R' interop.
                                                       # Defaults to off.
  --passthrough: string@passthrough-modes = 'auto'     # Graphics protocol passthrough [auto, none, screen, tmux].
                                                       # Used to show pixel graphics through multiplexers.
  --polite: string@on-off-modes = 'off'                # Polite mode [on, off].
                                                       # Inhibits escape sequences that may confuse other programs.
                                                       # Defaults to off.
  --align: string                                      # Horizontal and vertical alignment (e.g. "top,left").
  --clear                                              # Clear screen before processing each file.
  --exact-size: string@on-off-auto-modes               # Try to match the input's size exactly [auto, on, off].
  --fit-width                                          # Fit images to view's width, possibly exceeding its height.
  --font-ratio: string = '1/2'                         # Target font's width/height ratio. 
                                                       # Can be specified as a real number or a fraction.
                                                       # Defaults to 1/2. 
  --grid: string                                       # Lay out images in a grid of CxR columns/rows per screenful.
                                                       # C or R may be omitted, e.g. "--grid 4". Can be "auto".
  -g                                                   # Alias for "--grid auto".
  --label: string@on-off-modes                         # Labeling [on, off]. Filenames below images. Default off.
  -l                                                   # Alias for "--label on".
  --link: string@on-off-auto-modes = 'auto'            # Link labels [auto, on, off].
                                                       # Turns labels into clickable hyperlinks.
                                                       # Use with "--label on".
                                                       # Defaults to auto.
  --margin-bottom: int                                 # When terminal size is detected, reserve at least NUM rows at the bottom as a safety margin. Can be used to prevent images from scrolling out. Defaults to 1.
  --margin-right: int                                  # When terminal size is detected, reserve at least NUM columns safety margin on right-hand side. Defaults to 0.
  --scale: oneof<float, string>                        # Scale image, respecting view's dimensions. 1.0 approximates image's pixel dimensions. Specify "max" to fit view. Defaults to 1.0 for pixel graphics and 4.0 for symbols.
  --size : string                                      # Set maximum image dimensions in columns and rows. By default this will be equal to the view size.
  --stretch                                            # Stretch image to fit output dimensions; ignore aspect. Implies --scale max.
  --view-size: string                                  # Set the view size in columns and rows. By default this will be the size of your terminal, or 80x25 if size detection fails. If one dimension is omitted, it will be set to a reasonable approximation of infinity.
  --fg-only                                            # Leave the background color untouched. This produces character-cell output using foreground colors only.
  --symbols (-s): string@symbols                       # Specify character symbols to employ in final output.
  --glyph-file : path                                  # Load glyph information from FILE, which can be any font file supported by FreeType (TTF, PCF, etc).
  --fill: string@symbols = 'none'                      # Specify character symbols to use for fill/gradients. Defaults to none. See below for full usage.
  --work (-w): int = 5                                 # How hard to work in terms of CPU and memory [1-9]. 1 is the cheapest, 9 is the most accurate. Defaults to 5.
  --threads: int                                       # Maximum number of CPU threads to use. If left unspecified or negative, this will equal available CPU cores.
  --bg: string                                         # Background color of display (color name or hex).
  --colors (-c): string@color_modes                    # Set output color mode; one of [none, 2, 8, 16/8, 16, 240, 256, full]. Defaults to best guess.
  --color-extractor='average': string@color_extractors #  Method for extracting color from an area [average, median]. Average is the default.
  --color-space='rgb': string@color_spaces             # Color space used for quantization; one of [rgb, din99d]. Defaults to rgb, which is faster but less accurate.
  --dither = 'noise': string@dither_modes              # Set output dither mode; one of [none, ordered, diffusion, noise]. No effect with 24-bit color. Defaults to noise for sixels, none otherwise.
  --dither-grain='4x4': string                         # Set dimensions of dither grains in 1/8ths of a character cell [1, 2, 4, 8]. Defaults to 4x4.
  --dither-intensity=1.0: float                        # Multiplier for dither intensity [0.0 - inf]. Defaults to 1.0.
  --invert                                             # Swaps --fg and --bg. Useful with light terminal background.
  --preprocess (-p) = true                             # Image preprocessing [on, off]. Defaults to on with 16 colors or lower, off otherwise.
  --threshold (-t): float                              # Lower threshold for full transparency [0.0 - 1.0].
  ...args: string                                      # Additional arguments to pass to chafa
]


def color_spaces [] : nothing -> list<string> {
  [
    'rgb'
    'din99d'
  ]
}

def color_extractors [] : nothing -> list<string> {
  [
    'average'
    'median'
  ]
}

def color_modes [] : nothing -> list<string> {
  [
    'none'
    '2'
    '8'
    '16/8'
    '16'
    '240'
    '256'
    'full'
  ]
}

def dither_modes [] : nothing -> list<string> {
  [
    'none'
    'ordered'
    'diffusion'
    'noise'
  ]
}

def formats [] : nothing -> list<string> {
  [
    'iterm'
    'kitty'
    'sixels'
    'symbols'
  ]
}

def symbols [] : nothing -> list<string> {
  [
    'all'
    'ascii'
    'braille'
    'extra'
    'imported'
    'narrow'
    'solid'
    'ugly'
    'alnum'
    'bad'
    'diagonal'
    'geometric'
    'inverted'
    'none'
    'space'
    'vhalf'
    'alpha'
    'block'
    'digit'
    'half'
    'latin'
    'quad'
    'stipple'
    'wedge'
    'ambiguous'
    'border'
    'dot'
    'hhalf'
    'legacy'
    'sextant'
    'technical'
    'wide'
    ]
}

def models [] : nothing -> list<string> {
  [
    'birefnet-general'
    'birefnet-general-lite'
    'birefnet-portrait'
    'birefnet-dis'
    'birefnet-hrsod'
    'birefnet-cod'
    'birefnet-massive'
    'isnet-anime'
    'dis_custom'
    'isnet-general-use'
    'sam'
    'silueta'
    'u2net_cloth_seg'
    'u2net_custom'
    'u2net_human_seg'
    'u2net'
    'u2netp'
    'bria-rmbg'
    'ben_custom'
  ]
}

def on-off-modes [] : nothing -> list<string> {
  [
    'on'
    'off'
  ]
}
def on-off-auto-modes [] : nothing -> list<string> {
  [
    'auto'
    'on'
    'off'
  ]
}

def optimization-modes [] : nothing -> list<int> {
  1..9 | each { |i| $i }
}

def passthrough-modes [] : nothing -> list<string> {
  [
    'auto'
    'none'
    'screen'
    'tmux'
  ]
}

def probe-modes [] : nothing -> list<string> {
  [
    'any'
    'ctty'
    'stdio'
  ]
}
