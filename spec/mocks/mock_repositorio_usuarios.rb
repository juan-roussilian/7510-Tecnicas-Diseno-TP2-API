class MockRepositorioUsuarios
  def initialize
    @users = []
  end

  def find_by_telegram_username(telegram_username)
    user = @users.find { |u| u.telegram_username == telegram_username }
    raise ObjectNotFound.new(self.class.model_class, telegram_username) if user.nil?

    user
  end

  def save(user)
    @users << user
  end

  def load_example_users(number_of_users)
    (0..number_of_users).each do |i|
      save(Usuario.new("usuario#{i}", "test#{i}@test.com", i.to_s, "user#{i}"))
    end
  end

  def delete_all
    @users = []
  end
end
