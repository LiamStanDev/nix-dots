import Notifications from "./components/Notifications";

import { App } from "astal/gtk3";
import style from "./style.scss";

App.start({
  instanceName: "notifications",
  css: style,
  main() {
    App.get_monitors().map(Notifications);
  },
});
