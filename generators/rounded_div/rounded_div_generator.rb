require 'RMagick'

class RoundedDivGenerator < Rails::Generator::NamedBase

  attr_accessor :radius, :name, :body_color

  def manifest
    record do |m|
      @name = file_name
      @background_color = args[0] || 'white'
      @radius = Integer(args[1] || 5)
      @body_color = args[2] || 'blue'
      @image_directory = "public/images/#{@name}"

      puts "**************************************************************************************************"
      puts ""
      puts "Generating rounded div formatting with a corner radius of #{@radius} and a color of #{@body_color}"
      puts ""
      puts "  In your view template use the following markup:"
      puts "  note: the structure of this markup must be followed for proper formatting"
      puts ""
      puts "     <div id='#{@name}'>"
      puts "       <h2> ... </h2>"
      puts "       <p>"
      puts "         ..."
      puts "       </p>"
      puts "       <p class=\"more\">"
      puts "         <a href=\"#\">...</a>"
      puts "       </p>"
      puts "    </div>"
      puts ""
      puts "Don't forget to include the generated stylesheet in your layout or view,"
      puts "use the :pullquote symbol to automatically gather all of the generated stylesheets"
      puts "instead of manually including each one (use the :cache=>true option)"
      puts ""
      puts "  <%= stylesheet_link_tag :pullquote  %>"
      puts ""

      m.directory "public/stylesheets/#{@name}"
      m.directory @image_directory
      m.template 'css_template.erb', "public/stylesheets/#{@name}/pullquote.css"

      m.generate_corner_graphics @background_color, @radius, @body_color, @image_directory

    end
    

    
  end

  def banner
    "Usage: #{$0} #{spec.name} css_id_name background_svg_color corner_radius svg_color"
    ""
    "  note: use SVG Color Names (http://www.w3.org/TR/SVG/types.html#ColorKeywords)"
    "  Params:"
    "          css_id_name          is the name of the CSS ID selector that will be generated"
    "          background_svg_color is the name of the background color OUTSIDE of the rounded box"
    "          corner_radius        is the, um, radius of the corners"
    "          svg_color            is the color of the rounded box"
  end



end