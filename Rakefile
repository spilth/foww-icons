require "standard/rake"
require "victor"
require "zip"

VIEW_BOX = "0 0 256 256"

RANGES = [
  {
    color: "orange",
    background: "#EE721F",
    foreground: "black",
    corners: [:sw]
  },
  {
    color: "yellow",
    background: "#FDE64C",
    foreground: "black",
    corners: [:nw, :se]
  },
  {
    color: "red",
    background: "#E73430",
    foreground: "black",
    corners: [:ne, :se]
  },
  {
    color: "green",
    background: "#00A143",
    foreground: "black",
    corners: [:nw, :ne, :sw]
  },
  {
    color: "blue",
    background: "#009FE0",
    foreground: "black",
    corners: [:nw, :ne, :se, :sw]
  },
  {
    color: "black",
    background: "#000000",
    foreground: "white",
    corners: []
  }
]

def range_corners(svg, range)
  svg.rect x: 0, y: 0, width: 128, height: 128 if range[:corners].include?(:nw)
  svg.rect x: 128, y: 0, width: 128, height: 128 if range[:corners].include?(:ne)
  svg.rect x: 128, y: 128, width: 128, height: 128 if range[:corners].include?(:se)
  svg.rect x: 0, y: 128, width: 128, height: 128 if range[:corners].include?(:sw)
end

def range_frames(prefix)
  RANGES.each do |range|
    svg = Victor::SVG.new viewBox: VIEW_BOX, template: :html
    svg.build do
      range_corners(svg, range)

      yield(svg, range)
    end
    svg.save "output/svg/#{prefix}_#{range[:color]}"
  end
end

def range_circles(prefix)
  range_frames(prefix) do |svg, range|
    svg.circle cx: 128, cy: 128, r: 124, fill: range[:background], stroke: "black", stroke_width: 8

    yield(svg, range)
  end
end

def range_squares(prefix)
  range_frames(prefix) do |svg, range|
    svg.rect x: 7, y: 7, width: 242, height: 242, rx: 64, fill: range[:background], stroke: "black", stroke_width: 14

    yield(svg, range)
  end
end

def skill_icon(name)
  svg = Victor::SVG.new viewBox: VIEW_BOX, template: :html
  svg.build do
    svg.circle cx: 128, cy: 128, r: 124, fill: "white", stroke: "black", stroke_width: 8

    yield(svg)
  end
  svg.save "output/svg/skill_#{name}"
end

def quick_action_icon(name)
  svg = Victor::SVG.new viewBox: VIEW_BOX, template: :html
  svg.build do
    svg.line x1: "128", y1: "0", x2: "128", y2: "256", stroke: "black", stroke_width: "48"
    svg.line x1: "0", y1: "128", x2: "256", y2: "128", stroke: "black", stroke_width: "48"
    svg.line x1: "36", y1: "36", x2: "220", y2: "220", stroke: "black", stroke_width: "48"
    svg.line x1: "36", y1: "220", x2: "220", y2: "36", stroke: "black", stroke_width: "48"
    svg.circle cx: "128", cy: "128", r: "104", fill: "white", stroke: "black", stroke_width: "8"

    yield(svg)
  end
  svg.save "output/svg/quick_action_#{name}"
end

def awareness_symbol(svg, range)
  svg.ellipse cx: 128, cy: 128, rx: 108, ry: 60, fill: range[:foreground]
  svg.circle cx: 128, cy: 128, r: 44, fill: range[:background]
  svg.circle cx: 128, cy: 128, r: 12, fill: range[:foreground]
end

def move_symbol(svg, fill)
  svg.polygon points: "96 64 160 128 96 192", fill: fill
end

def charge_symbol(svg, fill)
  svg.polygon points: "64 64 128 128 64 192", fill: fill
  svg.polygon points: "128 64 192 128 128 192", fill: fill
end

def computer_symbol(svg)
  svg.rect x: "56", y: "48", width: "144", height: "104", fill: "white", stroke: "black", stroke_width: "12"
  svg.rect x: "54", y: "168", width: "148", height: "40", fill: "white", stroke: "black", stroke_width: "8"
  svg.rect x: "62", y: "176", width: "132", height: "32", fill: "black"
  svg.path d: "M 72 48 C 56 48, 56 152, 72 152", fill: "none", stroke: "black", stroke_width: "8"
  svg.path d: "M 184 48 C 200 48, 200 152, 184 152", fill: "none", stroke: "black", stroke_width: "8"
  svg.circle cx: "196", cy: "148", r: "4", fill: "white"
end

def lockpick_symbol(svg)
  svg.circle cx: 128, cy: 80, r: 40, fill: "black"
  svg.polygon points: "128 64 160 216 96 216", fill: "black"
end

def search_symbol(svg)
  svg.circle cx: 160, cy: 96, r: 52, fill: "white", stroke: "black", stroke_width: 20
  svg.line x1: 120, y1: 136, x2: 48, y2: 208, stroke: "black", stroke_width: 20
end

def heavy_weapon_symbol(svg)
  svg.g transform: "rotate(-45 128 128)" do
    svg.ellipse cx: 128, cy: 112, rx: 60, ry: 80, fill: "black"
    svg.polygon points: "128 128 184 184 72 184", fill: "black"
    svg.rect x: 72, y: 184, width: 112, height: 20
    svg.rect x: 72, y: 184, width: 16, height: 40
    svg.rect x: 168, y: 184, width: 16, height: 40
    svg.rect x: 104, y: 184, width: 48, height: 40
  end
end

def presence_symbol(svg, foreground, background)
  # Concentric Circles
  svg.circle cx: 128, cy: 128, r: 60, fill_opacity: 0, stroke: foreground, stroke_width: 16
  svg.circle cx: 128, cy: 128, r: 96, fill_opacity: 0, stroke: foreground, stroke_width: 16

  # "Erase" top/bottom of concentric circles
  svg.polygon points: "128 128 48 48 128 16 208 48", fill: background
  svg.polygon points: "128 128 48 208 128 240 208 208", fill: background

  # Top of Tower
  svg.circle cx: 128, cy: 128, r: 20, fill: foreground

  # Tower
  svg.polygon points: "116 236 124 160 132 160 140 236", fill: foreground
end

task :svg do
  begin
    Dir.mkdir("output")
  rescue Errno::EEXIST
    # Ignored
  end

  begin
    Dir.mkdir("output/svg")
  rescue Errno::EEXIST
    # Ignored
  end

  puts "Creating SVGs..."

  quick_action_icon("movement") do |svg|
    svg.line x1: 128, y1: 0, x2: 128, y2: 256, stroke: "black", stroke_width: 8
    svg.g(transform: "scale(0.5) translate(32,128)") { move_symbol(svg, "black") }
    svg.g(transform: "scale(0.5) translate(224,128)") { charge_symbol(svg, "black") }
  end

  quick_action_icon("attack") do |svg|
    svg.polygon points: "129 61 144 88 175 59 168 103 200 88 177 124 204 151 169 153 185 200 144 170 125 220 112 166 71 199 90 153 58 151 84 130 48 120 95 109 68 59 124 97 129 61", fill: "black"
  end

  quick_action_icon("expertise") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      svg.ellipse cx: 128, cy: 128, rx: 116, ry: 36, fill_opacity: 0, stroke: "black", stroke_width: 4
      svg.ellipse cx: 128, cy: 128, rx: 36, ry: 116, fill_opacity: 0, stroke: "black", stroke_width: 4
      svg.ellipse cx: 128, cy: 128, rx: 100, ry: 32, fill_opacity: 0, stroke: "black", stroke_width: 4, transform: "rotate(45, 128, 128)"
      svg.ellipse cx: 128, cy: 128, rx: 32, ry: 100, fill_opacity: 0, stroke: "black", stroke_width: 4, transform: "rotate(225, 128, 128)"
      svg.circle cx: 128, cy: 128, r: 16, fill: "black"
    end
  end

  quick_action_icon("prepare") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      awareness_symbol(svg, {background: "white", foreground: "black"})
    end
  end

  quick_action_icon("computers") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      computer_symbol(svg)
    end
  end

  quick_action_icon("heavy_weapon") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      heavy_weapon_symbol(svg)
    end
  end

  quick_action_icon("lockpick") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      lockpick_symbol(svg)
    end
  end

  quick_action_icon("search") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      search_symbol(svg)
    end
  end

  skill_icon("computer") do |svg|
    computer_symbol(svg)
  end

  skill_icon("lockpick") do |svg|
    lockpick_symbol(svg)
  end

  skill_icon("search") do |svg|
    search_symbol(svg)
  end

  skill_icon("presence") do |svg|
    presence_symbol(svg, "black", "white")
  end

  skill_icon("heavy_weapon") do |svg|
    svg.g transform: "rotate(-45 128 128)" do
      heavy_weapon_symbol(svg)
    end
  end

  range_circles("awareness") do |svg, range|
    awareness_symbol(svg, range)
  end

  range_circles("presence") do |svg, range|
    foreground = range[:foreground]
    background = range[:background]

    presence_symbol(svg, foreground, background)
  end

  range_squares("move") { |svg, range| move_symbol(svg, range[:foreground]) }
  range_squares("charge") { |svg, range| charge_symbol(svg, range[:foreground]) }
end

task zip: :svg do
  begin
    Dir.mkdir("output/zip")
  rescue Errno::EEXIST
    # Ignored
  end

  begin
    File.delete("output/zip/foww-icons.zip")
  rescue Errno::ENOENT
    # Ignored
  end

  puts "Creating Zip file of SVGs..."

  source_files = Dir.glob("output/svg/*.svg")
  Zip::File.open("output/zip/foww-icons.zip", create: true) do |zip|
    source_files.each do |source_file|
      puts "Adding #{source_file}..."
      zip.add("foww-icons/#{File.basename(source_file)}", source_file)
    end
  end

  puts "Done!"
  puts
end

task html: :zip do
  puts "Generating HTML..."

  FileUtils.copy("html/index.html", "output/index.html")

  puts "Done!"
  puts
end

task default: ["standard:fix", :html]
