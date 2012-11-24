class FakeGraph
  attr_accessor :user_id, :name, :first_name, :last_name

  def initialize
    @user_id    = '1234'
    @name       = 'Foo Barbaz'
    @first_name = 'Foo'
    @last_name  = 'Barbaz'
  end

  def get_object(name)
    {
      'id'         => @user_id,
      'name'       => @name,
      'first_name' => @first_name,
      'last_name'  => @last_name
    }
  end

end

def signin!(options = {})
  $graph        = options[:graph]        || FakeGraph.new
  $user_id      = options[:user_id]      || '1234'
  $access_token = options[:access_token] || '2345'

  $graph.user_id = $user_id

  ApplicationController.class_eval do
    alias :old_setup_user! :setup_user!

    def setup_user!
      @user_id      = $user_id
      @access_token = $access_token
      @graph        = $graph
    end
  end
end

def signout!
  ApplicationController.class_eval do
    alias :setup_user! :old_setup_user!
  end

  $user_id      = nil
  $access_token = nil
  $graph        = nil
end

def signin_and_out!(options = {})
  signin! options

  yield

  signout!
end

