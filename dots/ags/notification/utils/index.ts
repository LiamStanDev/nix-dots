export const getNotificationIcon = (
  app_name: string,
  app_icon: string,
  app_entry: string
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
