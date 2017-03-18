const fs = require('fs');
const path = require('path');

const promisify = (fn) =>
  new Promise((resolve, reject) =>
    fn((err, val) => (err ? reject(err) : resolve(val))));

class PackageList {

  constructor() {
    this._packageListPath = path.join(process.env.HOME, '.atom', 'installed-packages.txt');
  }

  getStoredPackageList() {
    return promisify(cb => fs.readFile(this._packageListPath, 'utf8', cb));
  }

  getInstalledPackageList() {
    return atom.packages.getLoadedPackages()
      .filter(pkg => !pkg.bundledPackage) // Remove built in Atom packages
      .map(pkg => pkg.name) // Discard version
      .sort()
      .join('\n') + '\n';
  }

  savePackageList(packageList) {
    return promisify(cb => fs.writeFile(this._packageListPath, packageList, { mode: 0o644 }, cb));
  }

  notifySuccess() {
    const msg = atom.notifications.addSuccess('Saved installed packages',
      { detail: this._packageListPath, dismissable: true });
    setTimeout(msg.dismiss.bind(msg), 5000);
  }

  notifyError(err) {
    const msg = atom.notifications.addError('Failed to save installed packages',
      { detail: err, dismissable: true });
    setTimeout(msg.dismiss.bind(msg), 5000);
  }

  update() {
    return this.getStoredPackageList().then((storedPackageList) => {
      const installedPackageList = this.getInstalledPackageList();
      if (storedPackageList !== installedPackageList) {
        return this.savePackageList(installedPackageList);
      } else {
        return false;
      }
    })
    .then(saved => saved !== false && this.notifySuccess())
    .catch(this.notifyError.bind(this));
  }

  register() {
    atom.packages.onDidLoadPackage(this.update.bind(this));
    atom.packages.onDidUnloadPackage(this.update.bind(this));
  }
}

module.exports = new PackageList();
