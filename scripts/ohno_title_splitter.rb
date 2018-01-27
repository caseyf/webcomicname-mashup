#!/usr/bin/env ruby

require 'chunky_png'
require 'optparse'

class OhnoTitleSplitter

  attr_accessor :black_threshold, :neighboring_rows, :allowed_offset_range

  def initialize(png_file, black_threshold, neighboring_rows, allowed_offset_range)
    @canvas = ChunkyPNG::Canvas.from_file(png_file)
    @image = @canvas.to_image
    @black_threshold = black_threshold
    @neighboring_rows = neighboring_rows
    @allowed_offset_range = allowed_offset_range
  end

  def save_without_title(output_filename, offset_adjustment)
    if @allowed_offset_range.include?(title_offset)
      puts "Writing image from offset #{title_offset}px to #{output_filename}..."
      offset = title_offset - offset_adjustment
      cropped = @canvas.crop(0, offset, @image.width, @image.height - offset)
      cropped.save(output_filename)
    else
      @canvas.save(output_filename)
    end
  end

  def save_title_only(output_filename, offset_adjustment)
    if @allowed_offset_range.include?(title_offset)
      puts "Writing title from 0px-#{title_offset}px to #{output_filename}..."

      offset = title_offset - offset_adjustment
      cropped = @canvas.crop(0, 0, @image.width, offset)
      cropped.save(output_filename)
    end
  end

  def title_offset
    @title_offset = find_title_offset
  end

  def is_close_to_black?(r, g, b)
    r < 40 && g < 40 && b < 40
  end

  def find_title_offset
    horizontal_lines = []
    percent_black_by_row = []

    width = @image.dimension.width
    height = @image.dimension.height

    (0..(height - 1)).each do |y|
      black_pixels = (0..(width - 1)).select do |x|
        pixel = @image[x,y]

        r = ChunkyPNG::Color.r(pixel)
        g = ChunkyPNG::Color.g(pixel)
        b = ChunkyPNG::Color.b(pixel)

        is_close_to_black?(r, g, b)
      end

      percent_black_by_row << black_pixels.length/width.to_f
    end

    percent_black_by_row.each_with_index do |val, index|
      p = percent_black_by_row
      next_rows = (0..@neighboring_rows).map {|row| p[index + row] || 0 }
      if next_rows.inject(0) {|sum, v| sum + v} >= @black_threshold
        horizontal_lines << index
      end
    end

    horizontal_lines.find {|l| @allowed_offset_range.include?(l) }
  end


end


if __FILE__ == $0
  input_file = nil
  output_file = nil
  output_title = nil

  # these are set up for 1280px oh no! comics
  offset_adjustment = 5
  black_threshold = 1.50
  neighboring_rows = 5

  parser = OptionParser.new do |opts|
    opts.banner = "Usage: ohno_title_splitter.rb [options]"

    opts.on("--input-file input_file", "PNG input file") {|f| input_file = f  }
    opts.on("--output-title title_file", "Output file name for comic title") {|f| output_title = f }
    opts.on("--output-file comic_file", "Output file name for comic with title removed")  {|f| output_file = f }
  end
  parser.parse!

  unless input_file
    puts parser.help
    exit -1
  end

  splitter = OhnoTitleSplitter.new(input_file, black_threshold, neighboring_rows, 25..100)
  if output_file
    splitter.save_without_title(output_file, offset_adjustment)
  end
  if output_title
    splitter.save_title_only(output_title, offset_adjustment)
  end

end

