module TicTacToeErrors
  class BadRequest < StandardError
    def initialize(message = nil)
      super(message)
    end
  end
end
