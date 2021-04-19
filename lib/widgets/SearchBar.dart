import 'package:cloutbook/common/utils.dart';
import 'package:cloutbook/config/palette.dart';
import 'package:cloutbook/stores/ExploreStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

final TextEditingController? _textInputController = TextEditingController();

class SearchBar extends HookWidget {
  final ExploreStore _exploreStore = GetIt.I<ExploreStore>();
  final _debouncer = Debouncer(milliseconds: 500);

  void handleSearchChange(searchKey) {
    if (searchKey.length > 0) {
      _debouncer.run(() => _exploreStore.getProfiles(searchKey));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Palette.secondaryForeground,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.search,
            size: 18.0,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: TextField(
              restorationId: '123',
              controller: _textInputController,
              cursorColor: Colors.white,
              onChanged: handleSearchChange,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration.collapsed(
                hintText: 'Seach',
                hintStyle: TextStyle(color: Palette.hintColor, fontSize: 14.0),
              ),
            ),
          ),
          Observer(builder: (_) {
            return Visibility(
              maintainState: true,
              visible: _exploreStore.profiles.length > 0,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _textInputController?.clear();
                  _exploreStore.profiles = [];
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 2, left: 8, right: 8),
                  color: Palette.secondaryForeground,
                  child: Icon(
                    CupertinoIcons.xmark,
                    size: 18.0,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
