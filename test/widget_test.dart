// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_app_template/main.dart';
import 'package:flutter_app_template/models/EntityDetails.dart';
import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:flutter_app_template/repository/database/main_entity_dao.dart';
import 'package:flutter_app_template/repository/http/web_clients/web_client.dart';
import 'package:flutter_app_template/screens/entity_detailing/EntityDetailing.dart';
import 'package:flutter_app_template/screens/main_entity_listing/MainEntityListing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  var genericEntityTitle = 'title';
  final genericEntityId = '0';
  final genericUrl = 'http';
  var mockedMainEntity = MainEntity(
      id: genericEntityId, title: genericEntityTitle, image_url: genericUrl);
  final mockDAO = MockDAO();
  final mockWebClient = MockWebClient();
  final fakeList = [mockedMainEntity].toList();

  testWidgets('When Opening MainEntityList Should Show MainEntityList',
      (WidgetTester tester) async {
    when(mockWebClient.getMainEntityList())
        .thenAnswer((realInvocation) async => fakeList);
    when(mockDAO.findAll()).thenAnswer((realInvocation) async => fakeList);

    await tester
        .pumpWidget(AppTemplate(webClient: mockWebClient, dAO: mockDAO));
    await tester.pumpAndSettle();

    final listView = find.byType(ListView);
    final mainEntityItem = find.byWidgetPredicate((widget) {
      if (widget is MainEntityItem) {
        return widget.mainEntity == mockedMainEntity;
      }
      return false;
    });

    verify(mockDAO.findAll()).called(1);
    expect(listView, findsOneWidget);
    expect(mainEntityItem, findsOneWidget);
  });

  testWidgets('When choosing a MainEntityItem Should show EntityDetails',
      (WidgetTester tester) async {
    when(mockWebClient.getMainEntityList())
        .thenAnswer((realInvocation) async => fakeList);
    when(mockDAO.findAll()).thenAnswer((realInvocation) async => fakeList);

    await tester
        .pumpWidget(AppTemplate(webClient: mockWebClient, dAO: mockDAO));
    await tester.pumpAndSettle();

    final mainEntityItem = find.byWidgetPredicate((widget) {
      if (widget is MainEntityItem) {
        return widget.mainEntity == mockedMainEntity;
      }
      return false;
    });

    when(mockWebClient.getEntityDetail(genericEntityId)).thenAnswer(
        (realInvocation) async => EntityDetails(
            image_url: genericUrl,
            title: genericEntityTitle,
            id: genericEntityId,
            price: '100',
            price_currency: '100'));

    await tester.tap(mainEntityItem);
    await tester.pumpAndSettle();

    final entityDetailScreen = find.byType(EntityDetaisScreen);
    final textTitle = find.byWidgetPredicate((widget) {
      if (widget is Text) {
        return widget.key == EntityDetaisScreen.titleKey &&
            widget.data == genericEntityTitle;
      }
      return false;
    });

    expect(entityDetailScreen, findsOneWidget);
    expect(textTitle, findsOneWidget);
    verify(mockWebClient.getEntityDetail(genericEntityId)).called(1);
  });
}

class MockDAO extends Mock implements DAO {}

class MockWebClient extends Mock implements WebClient {}
