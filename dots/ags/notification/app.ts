import { App } from "astal/gtk3";
import style from "./style.scss";
import NotificationPopups from "./components/NotificationPopups";

App.start({
  instanceName: "notifications",
  css: style,
  main() {
    App.get_monitors().map(NotificationPopups);
  },
});
