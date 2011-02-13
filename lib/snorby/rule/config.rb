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

require 'env'
require 'snorby/rule/database/database'

module Snorby

  module Rule
    
    module Config
      PATH = Home.join('.snorby')
      RULE_DIR = PATH.join('rules')

      PATH.mkdir unless PATH.directory?
      RULE_DIR.mkdir unless RULE_DIR.directory?
    end
    
  end
  
end
