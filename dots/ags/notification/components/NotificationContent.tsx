import { Gtk } from "astal/gtk3";
import AstalNotifd from "gi://AstalNotifd?version=0.1";

export default function NotificationContent({
  notification,
}: Props): JSX.Element {
  return (
    <box className="notification-card-content" hexpand vertical>
      <Header />
      <Body />
    </box>
  );
}

function Header(): JSX.Element {}

function NotificationIcon({ notification }: Props): JSX.Element {
  const { appName, appIcon, desktopEntry } = notification;

  return (
    <box className="notification-card-header" halign={Gtk.Align.START}>
      <box css="min-width: 2rem; min-height: 2rem;">
        <icon className="notification-icon" icon={appName} />
      </box>
    </box>
  );
}


function SummaryLabel({notification}: Props) JSX.Element {
  return <box className="notification-card-header" halign={Gtk.Align.START} valign={Gtk.Align.START} hexpand>
    <lable className="notification-card-header-label" halign={Gtk.Align.START}
      label={notification.summary}
    />
  </box>
}

function Body(): JSX.Element {}

type Props = {
  notification: AstalNotifd.Notification;
};

export const getNotificationIcon = (
  app_name: string,
  app_icon: string,
  app_entry: string,
): string => {
  const icon = icons.fallback.notification;

  if (iconExists(app_name)) {
    return app_name;
  } else if (app_name && iconExists(app_name.toLowerCase())) {
    return app_name.toLowerCase();
  }

  if (app_icon && iconExists(app_icon)) {
    return app_icon;
  }

  if (app_entry && iconExists(app_entry)) {
    return app_entry;
  }

  return icon;
};
