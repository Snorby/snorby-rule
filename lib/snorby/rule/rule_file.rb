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

require 'digest/md5'

module Snorby
  module Rule

    class RuleFile

      def initialize(path)
        @path = path
        @file = File.new(@path, 'r')
        @rules = []
      end

      def md5
        Digest::MD5.hexdigest(@path.to_s)
      end

      def to_s
        "#{@path}"
      end

      def rules(&block)
        while (line = @file.gets)
          @rules.push line unless line.match(/^\#/)
        end
        @rules
      end

      def exists?
        if File.exists?(@path)
          return true if File.readable?(@path)
        end
        false
      end

    end

  end
end
