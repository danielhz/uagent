

module UAgent

  class Parser

    @@keys = [['Mobile', :mobile],
              ['Opera Mini', :mobile],
              ['iPhone', :iphone, :mobile],
              ['ACER', :mobile],
              ['Alcatel', :mobile],
              ['AUDIOVOX', :mobile],
              ['BlackBerry', :blackberry, :mobile],
              ['CDM', :mobile],
              ['Ericsson', :mobile],
              ['LG', :mobile],
              ['LGE', :mobile],
              ['Motorola', :mobile],
              ['MOT', :mobile],
              ['NEC', :mobile],
              ['Nokia', :mobile],
              ['Panasonic', :mobile],
              ['QCI', :mobile],
              ['SAGEM', :mobile],
              ['SAMSUNG', :mobile],
              ['SEC', :mobile],
              ['Sanyo', :mobile],
              ['Sendo', :mobile],
              ['SHARP', :mobile],
              ['SonyEricsson', :mobile],
              ['Telit', :mobile],
              ['Telit_mobile_Terminals', :mobile],
              ['TSM', :mobile],
              ['Palm', :mobile]]
    @@priority = [:iphone, :blackberry, :mobile]

    def initialize(*keys)
      @keys = [:desktop, :mobile] + keys
    end

    def call(env)
      # Check devices in http user agent
      http_user_agent = env['HTTP_USER_AGENT']
      @@priority.select{ |k| @keys.include? k }.each do |key|
        @@keys.each do |sample|
          if /#{sample[0]}/ === http_user_agent
            return key if sample[(1...sample.size)].include? key
          end
        end
      end
      # As device is not found, return the default
      return @keys[0]
    end

  end

end
