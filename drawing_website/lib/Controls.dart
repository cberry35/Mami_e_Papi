import 'package:finger_painter/finger_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class Controls extends StatefulWidget {
  final PainterController? pc;
  final Uint8List? imgBytesList;

  const Controls({
    Key? key,
    this.pc,
    this.imgBytesList,
  }) : super(key: key);

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) {
    print(widget.imgBytesList.toString());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // display current drawing
            widget.imgBytesList != null
                ? Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        border: Border.all(
                          color: const Color(0xFF000000),
                          style: BorderStyle.solid,
                          width: 4.0,
                        ),
                        borderRadius: BorderRadius.zero,
                        shape: BoxShape.rectangle,
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x66000000),
                            blurRadius: 10.0,
                            spreadRadius: 4.0,
                          )
                        ],
                      ),
                      child: Image.memory(
                        widget.imgBytesList!,
                        gaplessPlayback: true,
                        fit: BoxFit.fitHeight,
                        width: 400,
                        height: 300,
                      ),
                    ),
                  )
                : const Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 140,
                      height: 140,
                    ),
                  ),

            const SizedBox(width: 30),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(backgroundColor: Colors.white, onPressed: () => widget.pc?.setStrokeColor(Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                            backgroundColor: const Color.fromARGB(255, 238, 194, 0),
                            onPressed: () => widget.pc?.setStrokeColor(const Color.fromARGB(255, 238, 194, 0))),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(backgroundColor: Colors.black, onPressed: () => widget.pc?.setStrokeColor(Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                            backgroundColor: Colors.blueGrey,
                            child: const Icon(Icons.delete_outline),
                            onPressed: () => widget.pc?.clearContent(clearColor: Colors.transparent)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // // Pen types
            // Column(
            //   children: [
            //     for (int i = 0; i < PenType.values.length; i++)
            //       OutlinedButton(
            //           child: Text(PenType.values[i].name),
            //           style: ButtonStyle(
            //               backgroundColor: widget.pc?.getState()?.penType.index == i
            //                   ? MaterialStateProperty.all(Colors.greenAccent.withOpacity(0.5))
            //                   : MaterialStateProperty.all(Colors.transparent)),
            //           onPressed: () {
            //             if (widget.pc != null) {
            //               widget.pc!.setPenType(PenType.values[i]);
            //               setState(() {});
            //             }
            //           }),
            //   ],
            // ),
          ],
        ),

        const SizedBox(height: 30),

        /// min stroke width
        Row(
          children: [
            Text('  min stroke '
                '${widget.pc?.getState()!.strokeMinWidth.toStringAsFixed(1)}'),
            Expanded(
              child: Slider.adaptive(
                  value: widget.pc?.getState()?.strokeMinWidth ?? 0,
                  min: 1,
                  max: 20,
                  onChanged: (value) {
                    if (widget.pc != null) {
                      widget.pc?.setMinStrokeWidth(value);
                      if (widget.pc!.getState()!.strokeMinWidth > widget.pc!.getState()!.strokeMaxWidth) {
                        widget.pc?.setMinStrokeWidth(widget.pc!.getState()!.strokeMaxWidth);
                      }
                      setState(() {});
                    }
                  }),
            ),
          ],
        ),

        /// max stroke width
        Row(
          children: [
            Text('  max stroke '
                '${widget.pc?.getState()!.strokeMaxWidth.toStringAsFixed(1)}'),
            Expanded(
              child: Slider.adaptive(
                  value: widget.pc?.getState()?.strokeMaxWidth ?? 0,
                  min: 1,
                  max: 40,
                  onChanged: (value) {
                    if (widget.pc != null) {
                      widget.pc!.setMaxStrokeWidth(value);
                      if (widget.pc!.getState()!.strokeMaxWidth < widget.pc!.getState()!.strokeMinWidth) {
                        widget.pc!.setMaxStrokeWidth(widget.pc!.getState()!.strokeMinWidth);
                      }
                      setState(() {});
                    }
                  }),
            ),
          ],
        ),

        /// blur
        Row(
          children: [
            Text('  blur '
                '${widget.pc?.getState()!.blurSigma.toStringAsFixed(1)}'),
            Expanded(
              child: Slider.adaptive(
                  value: widget.pc?.getState()?.blurSigma ?? 0,
                  min: 0.0,
                  max: 10.0,
                  onChanged: (value) {
                    if (widget.pc != null) {
                      widget.pc!.setBlurSigma(value);
                      setState(() {});
                    }
                  }),
            ),
          ],
        ),

        const SizedBox(height: 30),

        Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                print(widget.imgBytesList.toString());
              },
            )
          ],
        )
        // // blends modes
        // OutlinedButton(
        //     child: Text(ui.BlendMode.values[0].name),
        //     style: ButtonStyle(
        //         backgroundColor: widget.pc?.getState()?.blendMode.index == 0
        //             ? MaterialStateProperty.all(Colors.greenAccent.withOpacity(0.5))
        //             : MaterialStateProperty.all(Colors.transparent)),
        //     onPressed: () {
        //       widget.pc?.setBlendMode(ui.BlendMode.values[0]);
        //       setState(() {});
        //     }),
        // Wrap(
        //   spacing: 4,
        //   alignment: WrapAlignment.center,
        //   crossAxisAlignment: WrapCrossAlignment.center,
        //   children: [
        //     const Text(' blend modes: '),
        //     for (int i = 0; i < ui.BlendMode.values.length; i++)
        //       OutlinedButton(
        //           child: Text(ui.BlendMode.values[i].name),
        //           style: ButtonStyle(
        //               backgroundColor: widget.pc?.getState()?.blendMode.index == i
        //                   ? MaterialStateProperty.all(Colors.greenAccent.withOpacity(0.5))
        //                   : MaterialStateProperty.all(Colors.transparent)),
        //           onPressed: () {
        //             widget.pc?.setBlendMode(ui.BlendMode.values[i]);
        //             setState(() {});
        //           }),
        //   ],
        // ),
        // const SizedBox(height: 30),
      ],
    );
  }
}
