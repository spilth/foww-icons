require "standard/rake"
require "victor"
require "zip"

require_relative "symbols"
require_relative "icons"

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

  range_squares("move") { |svg, range| move_symbol(svg, range[:foreground]) }
  range_squares("charge") { |svg, range| charge_symbol(svg, range[:foreground]) }

  skill_icon("melee") { |svg| melee_symbol(svg) }
  skill_icon("pistol") { |svg| pistol_symbol(svg) }
  skill_icon("rifle") { |svg| rifle_symbol(svg) }
  skill_icon("heavy_weapon") { |svg| heavy_weapon_symbol(svg) }
  skill_icon("throw") { |svg| throw_symbol(svg, "black") }
  skill_icon("computer") { |svg| computer_symbol(svg) }
  skill_icon("lockpick") { |svg| lockpick_symbol(svg) }
  skill_icon("search") { |svg| search_symbol(svg) }
  skill_icon("presence") { |svg| presence_symbol(svg, "black", "white") }
  skill_icon("resist_battle_cry") { |svg| battle_cry_symbol(svg, "black") }
  skill_icon("health") { |svg| health_symbol(svg) }

  slashed_icon("battle_cry_immunity") { |svg| battle_cry_symbol(svg, "black") }
  slashed_icon("cannot_climb") { |svg| climb_symbol(svg, "black") }
  slashed_icon("unimpeded") { |svg| mountain_symbol(svg, "black") }

  quick_action_icon("movement") { |svg| movement_symbol(svg) }
  quick_action_icon("expertise") { |svg| svg.g(transform: "scale(0.8) translate(32,32)") { expertise_symbol(svg) } }
  quick_action_icon("attack") { |svg| svg.g(transform: "scale(0.64) translate(76 88)") { damage_symbol(svg) } }
  quick_action_icon("prepare") { |svg| svg.g(transform: "scale(0.8) translate(32,32)") { awareness_symbol(svg, {background: "white", foreground: "black"}) } }
  quick_action_icon("melee") { |svg| svg.g(transform: "scale(0.8) translate(32,32)") { melee_symbol(svg) } }
  quick_action_icon("pistol") { |svg| svg.g(transform: "scale(0.8) translate(32,32)") { pistol_symbol(svg) } }
  quick_action_icon("computers") { |svg| svg.g(transform: "scale(0.8) translate(32,32)") { computer_symbol(svg) } }
  quick_action_icon("rifle") { |svg| svg.g(transform: "scale(0.8) translate(32,32)") { rifle_symbol(svg) } }
  quick_action_icon("heavy_weapon") { |svg| svg.g(transform: "scale(0.8) translate(32,32)") { heavy_weapon_symbol(svg) } }
  quick_action_icon("throw") { |svg| svg.g(transform: "scale(0.8) translate(32,32)") { throw_symbol(svg, "black") } }
  quick_action_icon("lockpick") { |svg| svg.g(transform: "scale(0.8) translate(32,32)") { lockpick_symbol(svg) } }
  quick_action_icon("search") { |svg| svg.g(transform: "scale(0.8) translate(32,32)") { search_symbol(svg) } }

  armor_icon("physical") { |svg| svg.g(transform: "translate(74 64) scale(0.43)") { physical_symbol(svg) } }
  armor_icon("energy") { |svg| svg.g(transform: "translate(74 60) scale(0.45)") { energy_symbol(svg) } }
  armor_icon("radiation") { |svg| svg.g(transform: "translate(72 50) scale(0.49)") { radiation_symbol(svg) } }

  damage_icon("damage") { |svg| damage_symbol(svg) }
  damage_icon("physical") { |svg| physical_symbol(svg) }
  damage_icon("energy") { |svg| energy_symbol(svg) }
  damage_icon("radiation") { |svg| radiation_symbol(svg) }

  range_circles("awareness") { |svg, range| awareness_symbol(svg, range) }
  range_circles("presence") { |svg, range| presence_symbol(svg, range[:foreground], range[:background]) }
  range_circles("battle_cry") { |svg, range| battle_cry_symbol(svg, range[:foreground]) }
  range_circles("throw") { |svg, range| throw_symbol(svg, range[:foreground]) }
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

  FileUtils.cp_r("html/.", "output/")

  puts "Done!"
  puts
end

task :deploy do
  system "netlify deploy --prod --dir output"
end

task default: ["standard:fix", :html]
