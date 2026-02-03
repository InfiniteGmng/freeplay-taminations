/*

  Taminations Square Dance Animations
  Copyright (C) 2026 Brad Christie

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

import 'package:flutter/material.dart' as fm;
import 'package:provider/provider.dart' as pp;
import 'package:google_fonts/google_fonts.dart';

import '../common_flutter.dart';
import '../dance_model.dart';

class FreeplayDirectionsFrame extends fm.StatelessWidget {

  @override
  fm.Widget build(fm.BuildContext context) {
    return pp.Consumer<DanceModel>(
      builder: (context, danceModel, _) {
        return fm.Container(
          color: Color.LIGHTGRAY,
          child: fm.ListView(
            children: [
              fm.Container(
                color: Color.WHITE,
                padding: fm.EdgeInsets.all(16),
                margin: fm.EdgeInsets.only(bottom: 3),
                child: fm.Row(
                  children: [
                    fm.Expanded(
                      child: Button(
                        'Face Left',
                        onPressed: () => danceModel.rotateSelectedDancer(90.0),
                      ),
                    ),
                    fm.SizedBox(width: 10),
                    fm.Expanded(
                      child: Button(
                        'Face Right',
                        onPressed: () => danceModel.rotateSelectedDancer(-90.0),
                      ),
                    ),
                  ],
                ),
              ),
              fm.Container(
                color: Color.WHITE,
                margin: fm.EdgeInsets.only(bottom: 3),
                child: fm.InkWell(
                  onTap: () {
                    danceModel.asCouples = !danceModel.asCouples;
                    danceModel.notifyListeners();
                  },
                  child: fm.Row(
                    children: [
                      fm.Checkbox(
                        value: danceModel.asCouples,
                        onChanged: (value) {
                          danceModel.asCouples = value!;
                          danceModel.notifyListeners();
                        },
                      ),
                      fm.Expanded(
                        child: fm.Text(
                          'As Couples',
                          style: fm.TextStyle(
                            fontSize: 20,
                            fontWeight: fm.FontWeight.bold,
                            color: Color.BLACK,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (danceModel.selectedDancer != null)
                fm.Container(
                  color: Color.WHITE,
                  padding: fm.EdgeInsets.all(12),
                  child: fm.Text(
                    'Selected: ${danceModel.selectedDancer!.number}',
                    style: GoogleFonts.roboto(
                      color: Color.GRAY,
                      fontSize: 16,
                    ),
                    textAlign: fm.TextAlign.center,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
