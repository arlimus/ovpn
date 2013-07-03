require 'etc'
require 'securerandom'

module OpenVPN
  PATH = '/etc/openvpn'
  VERSION = '0.2'

  # returns an array of ['configfile','pid'] entries
  # eg: [ ["homevpn/vpn.ovpn","1234"], ... ]
  def get_running_profiles
    ps_aux.find_all do |i|
      i[1] =~ /^openvpn --config #{PATH}\//
    end.map do |i|
      [ i[1].sub(/^openvpn --config #{PATH}\//,''), i[0] ]
    end
  end

  def get_available_profiles
    Dir["#{PATH}/**/*ovpn"].
      map{|i| i.sub /^#{PATH}\//,''}
  end

  def find_profiles search
    get_available_profiles.
      find_all {|p| p =~ /#{search}/ }
  end

  def start_profile p
    return if p.nil? 
    # check if config exists
    path = File::join(PATH,p)
    if not File::file?(path)
      puts "Can't find profile file in '#{path}'."
      return
    end
    
    # don't run it if it is already running
    pid = pid_of(p)
    if not pid.nil?
      puts "Profile '#{p}' is already running (pid: #{pid})."
    else
      # start openvpn
      pname = p.gsub /[\/ !?$#]/,'_'
      run_as_root "openvpn --config '#{path}' > /var/log/ovpn-#{pname}-#{SecureRandom::uuid} 2>&1",  File::dirname(path), true
    end
  end

  def stop_profile name, pid
    return if pid.nil?
    puts "stopping '#{name}'"
    run_as_root "kill -9 #{pid}"
  end

  def pid_of profile, running_profiles_cache = nil
    ps = running_profiles_cache || get_running_profiles
    h = ps.find{|p| p[0] == profile}
    (h.nil?) ? nil : h[1]
  end

  private 

  def run_as_root cmd, path = '.', background = false
    rel_cmd = "cd #{path} && #{cmd}"
    puts "-- #{cmd}"
    if Process.euid != 0
      bg_opt = (background) ? '-b' : ''
      system "sudo #{bg_opt} sh -c \"#{rel_cmd}\""
    else
      system rel_cmd + ( (background) ? ' &' : '' )
    end
  end

  # get a list of all running processes
  # each line has the form [pid, command]
  def ps_aux
    `ps -o pid,command -a -x`.
      split("\n").
      map{|i| i.match(/^[ ]*(?<pid>[0-9]+)[ ](?<cmd>.*)/)}.
      compact.
      map{|i| [i[:pid], i[:cmd]] }
  end

end
