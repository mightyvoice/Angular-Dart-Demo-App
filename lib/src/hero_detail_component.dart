import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'hero_service.dart';
import 'hero.dart';

@Component(
  selector: 'hero-detail',
  templateUrl: 'hero_detail_component.html',
  styleUrls: const ['hero_detail_component.css'],
  directives: const [CORE_DIRECTIVES, formDirectives],
)
class HeroDetailComponent implements OnInit {
  final HeroService _heroService;
  final RouteParams _routeParams;
  final Location _location;

  Hero hero;

  HeroDetailComponent(this._heroService, this._routeParams, this._location);

  Future<Null> ngOnInit() async {
    var _id = _routeParams.get('id');
    var id = int.parse(_id ?? '', onError: (_) => null);
    if (id != null) hero = await (_heroService.getHero(id));
  }

  void goBack() => _location.back();

  Future<Null> save() async {
    await _heroService.update(hero);
    goBack();
  }

}
