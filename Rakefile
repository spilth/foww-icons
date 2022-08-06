require "standard/rake"
require "victor"
require "zip"

VIEW_BOX = "-16 0 288 256"

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

def melee_symbol(svg)
  svg.g transform: "translate(-16 0)" do
    svg.path d: "M95 89c-1-2-19-45-3-53 5-3-3 24 31 35l37 62 15-9h4c1 2 1 4-1 5l-18 12c0 2 1 5 3 7 31 24 40 60 40 60s16 2 10 7l-10 9-12 5c-8 4-3-11-3-11s-29-24-39-61c0-3-3-5-5-6l-19 12h-4c-1-2-1-4 1-5l15-10-42-59Z"
  end
end

def pistol_symbol(svg)
  svg.path fill: "none", stroke: "black", stroke_width: "6", d: "M100 110c-2 7-2 46 56 30"
  svg.path fill: "none", stroke: "black", stroke_width: "6", d: "M130 111c2 8 3 13-1 23"
  svg.path d: "M41 77h162l12 35-20 20 20 58-48 9-24-85H58l-5-13-12-3V77Z"
end

def rifle_symbol(svg)
  svg.g transform: "translate(-16 0)" do
    svg.path d: "m17 40 3 17 27 14 9-8 76 29 7 8 73 35 3 12 11 3 53 33-22 28-51-52-1 31-17-1-1-30-14-16-6-2-42-23-10-2L7 57l10-17Z"
    svg.path fill: "none", stroke: "black", stroke_width: "20", d: "M101 167c44-15 46-24 57-39"
    svg.path fill: "white", d: "m57 70 16 6v6l-18-7 2-5Z"
  end
end

def computer_symbol(svg)
  svg.rect x: "56", y: "48", width: "144", height: "104", fill: "white", stroke: "black", stroke_width: "12"
  svg.rect x: "56", y: "48", rx: 20, ry: 60, width: "144", height: "104", fill: "white", stroke: "black", stroke_width: "12"
  svg.rect x: "54", y: "168", width: "148", height: "40", fill: "white", stroke: "black", stroke_width: "8"
  svg.rect x: "62", y: "176", width: "132", height: "32", fill: "black"
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

def throw_symbol(svg, foreground)
  svg.g transform: "translate(-16 0)" do
    svg.ellipse cx: "76", cy: "87", fill: "none", stroke: foreground, stroke_width: "10", rx: "28", ry: "27"
    svg.path fill: foreground, d: "m127 83-2 16h60l-7-37h13l-1-16s1-5-5-5h-59L95 67l9 16m-17-7s-20 37-19 92c0 3 10 10 13 0 0-15-2-65 21-71L87 76Zm91 105c-2 11-5 19-9 26-2 5-5 8-8 10a53 53 0 0 1-12 0c-3-2-6-5-9-10l-9-26h47Zm-55 0a99 99 0 0 0 12 33c-14-6-26-18-34-33h22Zm63 0h21c-7 15-18 26-32 32l1-2c4-7 8-18 10-30Zm-65-37a178 178 0 0 0 1 29H98a77 77 0 0 1-4-29h27Zm60 0a170 170 0 0 1-2 29h-49a162 162 0 0 1-1-29h52Zm8 0h25a79 79 0 0 1-4 29h-22a170 170 0 0 0 1-29Zm-62-37c-3 9-5 19-6 30H95c2-11 6-22 12-30h20Zm47 0c3 8 5 19 6 30h-51c1-11 3-22 6-30h39Zm9 0h18c6 8 10 19 12 30h-25l-5-30Z"
  end
end

def battle_cry_symbol(svg, foreground)
  svg.g transform: "translate(-16 0)" do
    svg.path d: "m125 26 26 22-22 28-27-15 23-35Zm34 27 18 16-24 31v-8l-17-12 23-27Zm24 21 22 18-39 45-22-12 39-51Zm29 24 19 17-44 37-13-10 38-44Z", fill: foreground
    svg.path d: "M143 92 93 68l-41 57 60 101h72s20 0 35-91c-28 22-36 30-36 30s-19-30-80-39c-9-1-1-20 8-20 20 0 34 3 32-14Z", fill: foreground
  end
end

def health_symbol(svg)
  svg.g transform: "translate(-16 0)" do
    svg.path fill: "black", d: "M144 222c-36-77-100-38-100-109 0-34 32-47 48-47 18 0 36 11 52 30 16-19 34-30 52-30 16 0 48 13 48 47 0 71-64 32-100 109Z"
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

  quick_action_icon("melee") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      melee_symbol(svg)
    end
  end

  quick_action_icon("pistol") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      pistol_symbol(svg)
    end
  end

  quick_action_icon("computers") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      computer_symbol(svg)
    end
  end

  quick_action_icon("rifle") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      rifle_symbol(svg)
    end
  end

  quick_action_icon("heavy_weapon") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      heavy_weapon_symbol(svg)
    end
  end

  quick_action_icon("throw") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      throw_symbol(svg, "black")
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

  skill_icon("melee") do |svg|
    melee_symbol(svg)
  end

  skill_icon("pistol") do |svg|
    pistol_symbol(svg)
  end

  skill_icon("rifle") do |svg|
    rifle_symbol(svg)
  end

  skill_icon("heavy_weapon") do |svg|
    heavy_weapon_symbol(svg)
  end

  skill_icon("throw") do |svg|
    throw_symbol(svg, "black")
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

  skill_icon("battle_cry") do |svg|
    battle_cry_symbol(svg, "black")
  end

  skill_icon("health") do |svg|
    health_symbol(svg)
  end

  range_circles("awareness") do |svg, range|
    awareness_symbol(svg, range)
  end

  range_circles("presence") do |svg, range|
    foreground = range[:foreground]
    background = range[:background]

    presence_symbol(svg, foreground, background)
  end

  range_circles("battle_cry") do |svg, range|
    battle_cry_symbol(svg, range[:foreground])
  end

  range_circles("throw") do |svg, range|
    throw_symbol(svg, range[:foreground])
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

task :deploy do
  system "netlify deploy --prod --dir output"
end

task default: ["standard:fix", :html]
