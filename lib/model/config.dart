enum Flavor { DEVELOPMENT, PRODUCTION }

class Config {
  static Flavor appFlavor = Flavor.DEVELOPMENT;

  static String get host {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'prod.todowoo.online';
      case Flavor.DEVELOPMENT:
        return '127.0.0.1:8000';
    }
  }
}

Future runConfig(Flavor flavor) async {
  Config.appFlavor = flavor;
}
