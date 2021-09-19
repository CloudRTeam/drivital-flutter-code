const rootRoute = '/';

const wrapperRoute = '/wrapper';

const overviewPageDisplayName = 'Overview';
const overviewPageRoute = '/overview';

const devicesPageDisplayName = 'Devices';
const devicesPageRoute = '/devices';

const clientsPageDisplayName = 'Drivers';
const clientsPageRoute = '/clients';

const authenticationPageDisplayName = 'Log out';
const authenticationPageRoute = '/auth';

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(devicesPageDisplayName, devicesPageRoute),
  MenuItem(clientsPageDisplayName, clientsPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
