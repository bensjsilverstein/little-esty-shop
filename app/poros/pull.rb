class Pull
    attr_reader :number
    
    def initialize(data)
        @number = data[:number]
    end
end