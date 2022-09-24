# frozen_string_literal: true

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
    corners: %i[nw se]
  },
  {
    color: "red",
    background: "#E73430",
    foreground: "black",
    corners: %i[ne se]
  },
  {
    color: "green",
    background: "#00A143",
    foreground: "black",
    corners: %i[nw ne sw]
  },
  {
    color: "blue",
    background: "#009FE0",
    foreground: "black",
    corners: %i[nw ne se sw]
  },
  {
    color: "black",
    background: "#000000",
    foreground: "white",
    corners: []
  }
].freeze

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

def slashed_icon(name)
  svg = Victor::SVG.new viewBox: VIEW_BOX, template: :html
  svg.build do
    svg.circle cx: 128, cy: 128, r: 128, fill: "white"

    yield(svg)

    svg.line x1: 40, y1: 216, x2: 216, y2: 40, stroke: "#E4091C", stroke_width: 36
    svg.circle cx: 128, cy: 128, r: 124, fill: "none", stroke: "black", stroke_width: 8
  end
  svg.save "output/svg/#{name}"
end

def skill_icon(name)
  svg = Victor::SVG.new viewBox: VIEW_BOX, template: :html
  svg.build do
    svg.circle cx: 128, cy: 128, r: 124, fill: "white", stroke: "black", stroke_width: 8

    yield(svg)
  end
  svg.save "output/svg/skill_#{name}"
end

def armor_icon(name)
  svg = Victor::SVG.new viewBox: VIEW_BOX, template: :html
  svg.build do
    helmet_symbol(svg)

    yield(svg)
  end
  svg.save "output/svg/armor_#{name}"
end

def damage_icon(name)
  svg = Victor::SVG.new viewBox: VIEW_BOX, template: :html
  svg.build do
    yield(svg)
  end
  svg.save "output/svg/damage_#{name}"
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
