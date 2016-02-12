require 'rufus-scheduler'


peer_rotation = Rufus::Scheduler.singleton

scheduler = Rufus::Scheduler.new(:lockfile => ".rufus-scheduler.lock")

unless scheduler.down?

  # Every monday, 5 minutes after midnight update rotation
  peer_rotation.cron '5 0 * * 1' do
    PeerRotation.update_rotation
  end

end
