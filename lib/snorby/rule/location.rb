# Snorby - All About Simplicity.
#
# Copyright (c) 2010 Dustin Willis Webber (dustin.webber at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

require 'fileutils'
require 'pathname'
require 'snorby/rule/rule_file'

module Snorby

  module Rule

    class Location

      FORMATS = [
        :tar,
        :http,
        :https,
        :path
      ]

      attr_reader :format, :errors, :filename
      attr_accessor :file, :path, :temp_dir

      def initialize(path, options={})
        @path = path
        @errors = []

        if options[:format]
          @format = options[:format].to_sym
        end

        if options[:force]
          @force = options[:force]
        end

        @temp_dir = Pathname.new('/tmp/snorby-rules')
      end

      def unpack
        return false if files.to_a.empty?
        true
      end

      def valid?
        return true if fetch_and_preprocess
        false
      end

      def fetch_and_preprocess
        return false unless valid_location_type?

        case @format
        when :tar
          extract_and_return_files
        when :http, :https
          download_and_return_files
        when :path
          return_files
        end
      end

      def files(&block)
        return enum_for(:files) unless block

        unless defined?(@files)

          @files = []
          rule_files = File.join("**", "*.rules")

          Dir.glob(rule_files).each do |file|
            path = Pathname.new(file)
            next unless path.parent.to_s == 'rules'
            @files.push RuleFile.new(path)
          end
          
        end

        if @files.kind_of?(Array)
          @files.each(&block)
        else
          block.call(@files)
        end
      end
      alias :rule_file :files

      def filenames
        files.collect do |file|
          File.basename(file)
        end
      end

      def cleanup!
        FileUtils.rm_rf(@temp_dir)
      end

      private

        def extract_and_return_files
          if file_exists?
            prepare_new_location

            Dir.chdir(@temp_dir)
            `tar xvf #{@path} 2> /dev/null`
          else
            @errors << ['Extration Error', "Unable to location #{@path}"]
          end
        end

        def download_and_return_files

        end

        def return_files
          @path
        end

        def prepare_new_location
          FileUtils.mkdir_p(@temp_dir)

          FileUtils.cp_r(@path, @temp_dir)

          @file = File.new(@path)
          @path = File.join(@temp_dir, @filename)
        end

        def valid_location_type?
          return true if FORMATS.include?(@format)
          raise(UnknownLocationType, "#{@format} is not a valid location type.")
        end

        def file_exists?
          if File.exists?(@path)
            @file = File.new(@path)
            @filename = File.basename(@file)
            true
          else
            false
          end
        end

    end

  end

end
