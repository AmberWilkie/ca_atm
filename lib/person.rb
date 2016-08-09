class Person

  attr_accessor :name, :cash, :account
  @name = nil

  def initialize(args = {}) #it's not taking name: 'thomas' from the spec file and I don't know why. Works if I put name: 'thomas' in here.
    @name = name
    access_user_name(name)

  end

  def access_user_name(name)
    if name != nil
      @name = name
    else
      raise 'A name is required'
    end

  end

end