

module UAgent

  class Parser

    @@keys = [['Opera Mini', :mobile],
              ['iPhone', :mobile],
              ['ACER', :mobile],
              ['Alcatel', :mobile],
              ['AUDIOVOX', :mobile],
              ['BlackBerry', :mobile],
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
    def initialize(keys = [:desktop, :mobile])
      @keys = keys
    end

    def call(env)
      # Check devices in http user agent
      http_user_agent = env['HTTP_USER_AGENT']
      @@keys.each do |key|
        if /#{key[0]}/ === http_user_agent
          key[(1...key.size)].each do |user_agent|
            return user_agent if @keys.include? user_agent
          end
        end
      end
      # As device is not found, return the default
      return @keys[0]
    end

  end

end
