class ManageIQ::Providers::IbmPowerVc::CloudManager::EventCatcher < ManageIQ::Providers::BaseManager::EventCatcher
  require_nested :Runner

  def self.settings_name
    :event_catcher_ibm_power_vc
  end

  def self.all_valid_ems_in_zone
    require 'manageiq/providers/openstack/legacy/openstack_event_monitor'
    super.select do |ems|
      ems.sync_event_monitor_available?.tap do |available|
        _log.info("Event Monitor unavailable for #{ems.name}.  Check log history for more details.") unless available
      end
    end
  end
end
