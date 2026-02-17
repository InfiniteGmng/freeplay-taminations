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
              // Directional Grid
              fm.Container(
                color: Color.WHITE,
                padding: fm.EdgeInsets.all(8),
                margin: fm.EdgeInsets.only(bottom: 3),
                child: fm.Column(
                  children: [
                    _buildRow(danceModel, [-1, -1], [0, -1], [1, -1],
                        fm.Icons.north_west, fm.Icons.north, fm.Icons.north_east),
                    fm.Row(
                      children: [
                        _dirButton(danceModel, -1, 0, fm.Icons.west),
                        _toggleButton(danceModel),
                        _dirButton(danceModel, 1, 0, fm.Icons.east),
                      ],
                    ),
                    _buildRow(danceModel, [-1, 1], [0, 1], [1, 1],
                        fm.Icons.south_west, fm.Icons.south, fm.Icons.south_east),
                  ],
                ),
              ),
              // Rotation Buttons
              fm.Container(
                color: Color.WHITE,
                padding: fm.EdgeInsets.all(16),
                margin: fm.EdgeInsets.only(bottom: 3),
                child: fm.Row(
                  children: [
                    fm.Expanded(
                      child: Button(
                        'Face Left',
                        onPressed: () => danceModel.rotateSelectedDancer(
                            danceModel.halfStepMode ? 45.0 : 90.0),
                      ),
                    ),
                    fm.SizedBox(width: 10),
                    fm.Expanded(
                      child: Button(
                        'Face Right',
                        onPressed: () => danceModel.rotateSelectedDancer(
                            danceModel.halfStepMode ? -45.0 : -90.0),
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
                    danceModel.parametersChanged();
                  },
                  child: fm.Row(
                    children: [
                      fm.Checkbox(
                        value: danceModel.asCouples,
                        onChanged: (value) {
                          danceModel.asCouples = value!;
                          danceModel.parametersChanged();
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

  fm.Widget _buildRow(DanceModel model, List<int> d1, List<int> d2, List<int> d3,
      fm.IconData i1, fm.IconData i2, fm.IconData i3) {
    return fm.Row(
      children: [
        _dirButton(model, d1[0], d1[1], i1),
        _dirButton(model, d2[0], d2[1], i2),
        _dirButton(model, d3[0], d3[1], i3),
      ],
    );
  }

  fm.Widget _dirButton(DanceModel model, int dx, int dy, fm.IconData icon) {
    return fm.Expanded(
      child: fm.IconButton(
        icon: fm.Icon(icon, size: 30, color: Color.BLACK),
        onPressed: () {
          final step = model.halfStepMode ? 1.0 : 2.0;
          model.moveSelectedDancer(dx * step, dy * step);
        },
      ),
    );
  }

  fm.Widget _toggleButton(DanceModel model) {
    return fm.Expanded(
        child: fm.InkWell(
            onTap: () {
              model.halfStepMode = !model.halfStepMode;
            },
            child: fm.Container(
              width: 50,
              height: 50,
              decoration: fm.BoxDecoration(
                shape: fm.BoxShape.circle,
                color: model.halfStepMode ? Color.BLUE : Color.LIGHTGRAY,
                border: fm.Border.all(color: Color.BLACK),
              ),
              alignment: fm.Alignment.center,
              child: fm.Text(
                model.halfStepMode ? '1/2' : 'Full',
                style: fm.TextStyle(
                    color: model.halfStepMode ? Color.WHITE : Color.BLACK,
                    fontWeight: fm.FontWeight.bold),
              ),
            )));
  }
}
