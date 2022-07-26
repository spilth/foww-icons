require "standard/rake"
require "victor"

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

def range_shapes(prefix)
  RANGES.each do |range|
    svg = Victor::SVG.new viewBox: "0 0 256 256", template: :html
    svg.build do
      range_corners(svg, range)

      yield(svg, range)
    end
    svg.save "output/#{prefix}_#{range[:color]}"
  end
end

def range_circles(prefix)
  range_shapes(prefix) do |svg, range|
    svg.circle cx: 128, cy: 128, r: 124, fill: range[:background], stroke: "black", stroke_width: 8

    yield(svg, range)
  end
end

def range_squares(prefix)
  range_shapes(prefix) do |svg, range|
    svg.rect x: 7, y: 7, width: 242, height: 242, rx: 64, fill: range[:background], stroke: "black", stroke_width: 14

    yield(svg, range)
  end
end

def skill_icon(name)
  svg = Victor::SVG.new viewBox: "0 0 256 256", template: :html
  svg.build do
    svg.circle cx: 128, cy: 128, r: 124, fill: "white", stroke: "black", stroke_width: 8

    yield(svg)
  end
  svg.save "output/skill_#{name}"
end

def quick_action_icon(name)
  svg = Victor::SVG.new viewBox: "0 0 256 256", template: :html
  svg.build do
    svg.line x1: "128", y1: "0", x2: "128", y2: "256", stroke: "black", stroke_width: "48"
    svg.line x1: "0", y1: "128", x2: "256", y2: "128", stroke: "black", stroke_width: "48"
    svg.line x1: "36", y1: "36", x2: "220", y2: "220", stroke: "black", stroke_width: "48"
    svg.line x1: "36", y1: "220", x2: "220", y2: "36", stroke: "black", stroke_width: "48"
    svg.circle cx: "128", cy: "128", r: "104", fill: "white", stroke: "black", stroke_width: "8"

    yield(svg)
  end
  svg.save "output/quick_action_#{name}"
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

task :generate_svgs do
  begin
    Dir.mkdir("output")
  rescue Errno::EEXIST
    # Ignored
  end

  quick_action_icon("movement") do |svg|
    svg.g transform: "scale(0.5) translate(32,128)" do
      move_symbol(svg, "black")
    end
    svg.g transform: "scale(0.5) translate(224,128)" do
      charge_symbol(svg, "black")
    end
    svg.line x1: 128, y1: 0, x2: 128, y2: 256, stroke: "black", stroke_width: 8
  end

  quick_action_icon("prepare") do |svg|
    svg.g transform: "scale(0.8) translate(32,32)" do
      awareness_symbol(svg, {background: "white", foreground: "black"})
    end
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

  skill_icon("search") do |svg|
    svg.circle cx: 160, cy: 96, r: 52, fill: "white", stroke: "black", stroke_width: 20
    svg.line x1: 120, y1: 136, x2: 48, y2: 208, stroke: "black", stroke_width: 20
  end

  skill_icon("lockpick") do |svg|
    svg.circle cx: 128, cy: 80, r: 40, fill: "black"
    svg.polygon points: "128 64 160 216 96 216", fill: "black"
  end

  skill_icon("computer") do |svg|
    svg.rect x: "56", y: "48", width: "144", height: "104", fill: "white", stroke: "black", stroke_width: "12"
    svg.rect x: "54", y: "168", width: "148", height: "40", fill: "white", stroke: "black", stroke_width: "8"
    svg.rect x: "62", y: "176", width: "132", height: "32", fill: "black"
    svg.path d: "M 72 48 C 56 48, 56 152, 72 152", fill: "none", stroke: "black", stroke_width: "8"
    svg.path d: "M 184 48 C 200 48, 200 152, 184 152", fill: "none", stroke: "black", stroke_width: "8"
    svg.circle cx: "196", cy: "148", r: "4", fill: "white"
  end

  range_circles("awareness") do |svg, range|
    awareness_symbol(svg, range)
  end

  range_circles("presence") do |svg, range|
    # Concentric Circles
    svg.circle cx: 128, cy: 128, r: 60, fill_opacity: 0, stroke: range[:foreground], stroke_width: 16
    svg.circle cx: 128, cy: 128, r: 96, fill_opacity: 0, stroke: range[:foreground], stroke_width: 16

    # "Erase" top/bottom of concentric circles
    svg.polygon points: "128 128 48 48 128 16 208 48", fill: range[:background]
    svg.polygon points: "128 128 48 208 128 240 208 208", fill: range[:background]

    # Top of Tower
    svg.circle cx: 128, cy: 128, r: 20, fill: range[:foreground]

    # Tower
    svg.polygon points: "116 236 124 160 132 160 140 236", fill: range[:foreground]
  end

  range_squares("move") do |svg, range|
    move_symbol(svg, range[:foreground])
  end

  range_squares("charge") do |svg, range|
    charge_symbol(svg, range[:foreground])
  end
end

task default: ["standard:fix", :generate_svgs]
