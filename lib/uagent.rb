

module UAgent

  class Parser

    attr_reader :keys, :specific_keys

    @@default_database = {
      :mobile => ['Mobile', 'Opera Mini', 'iPhone', 'ACER', 'Alcatel', 'AUDIOVOX',
                  'BlackBerry', 'CDM', 'Ericsson', 'LG', 'LGE', 'Motorola', 'MOT',
                  'NEC', 'Nokia', 'Panasonic', 'QCI', 'SAGEM', 'SAMSUNG', 'SEC',
                  'Sanyo', 'Sendo', 'SHARP', 'SonyEricsson', 'Telit',
                  'Telit_mobile_Terminals', 'TSM', 'Palm'],
      :iphone => ['iPhone'],
      :blackberry => ['BlackBerry']
    }

    def initialize(*specific_keys)
      @specific_keys = specific_keys.clone
      @keys = [:desktop, :mobile] + @specific_keys
      set_database @@default_database
    end

    def set_database(database)
      @database = database.clone
      @database.each do |k,v|
        @database[k] = Regexp.new( "(" + v.join("|") + ")" )
      end
    end

    def call(env)
      # Check devices in http user agent
      http_user_agent = env['HTTP_USER_AGENT']
      (@specific_keys + [:mobile]).each do |k|
        return k if @database[k] === http_user_agent
      end
      # Device is not found, return the default
      return :desktop
    end

  end

end
