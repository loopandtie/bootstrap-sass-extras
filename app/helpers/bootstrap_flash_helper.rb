module BootstrapFlashHelper
  ALERT_TYPES_MAP = {
    notice: :success,
    alert: :danger,
    error: :danger,
    info: :info,
    warning: :warning
  }.freeze

  def bootstrap_flash
    safe_join(flash.each_with_object([]) do |(type, message), messages|
                next if message.blank? || !message.respond_to?(:to_str)
                type = ALERT_TYPES_MAP.fetch(type.to_sym, type)
                messages << flash_container(type, message)
              end, "\n").presence
  end

  def flash_container(type, message)
    content_tag :div, class: "alert alert-#{type} alert-dismissable" do
      btn = button_tag type: "button", class: "close", data: { dismiss: "alert" }, 'aria-label' => 'Close alert' do
        "&times;".html_safe
      end
      [message, btn].join('').html_safe
    end
  end
end
