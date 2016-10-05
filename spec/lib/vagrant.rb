class Vagrant

  private

  @ssh_host = nil
  @ssh_user = nil
  @ssh_keys = nil
  @ssh_port = nil

  def initialize
    c = `vagrant ssh-config`
    if c != ''
      c.each_line do |l|
        if m = /hostname (.*)/i.match(l)
          @ssh_host = m[1]
        elsif m = /user (.*)/i.match(l)
          @ssh_user = m[1]
        elsif m = /identityfile (.*)/i.match(l)
          @ssh_keys = [m[1].gsub(/"/, '')]
        elsif m = /port (.*)/i.match(l)
          @ssh_port = m[1]
        end
      end
    end
  end

  public
  attr_reader :ssh_host, :ssh_user, :ssh_keys, :ssh_port

end
