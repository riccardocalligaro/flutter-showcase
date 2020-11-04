# timer

A simple timer with a beautiful design.

<div style="width:100%; text-align:center;" >
<img src="https://i.imgur.com/108QHOU.png" height="500px" alt="app screenshot">
</div>

## Assignment

Create a Flutter application for a stopwatch or seconds timer from the basic application:
- ✔️ a stream acts as a ticker
- ✔️ the previous stream can be mapped to another stream to keep the seconds (with evaluation bonus) 

## File structure

- `main.dart`, entrypoint for the application
- `timer/`
    - `timer_page.dart`, the stateful widget for the timer page that contains the timer and the controls
    - `widget/`
        - `timer_widget.dart`, the timer, this contains the stream and all the logic
        - `wave_background.dart`, simple stateless widget that uses the `wave` library to make beautiful waves to use as the background
- `test`
    - `timer_page_test.dart`, simple test to check that the application at the start shows the correct button

## Use of streams

Since the project requirement was not to use `Timer.periodic()` I used `Stream.periodic` that emits a value every `duration` seconds and then there is a `StreamSubscription` that listents to the `Stream.period` and sets the state of the values every `duration`

We can't put the update directly the updateCall inside the `Stream.periodic()` because then we wouldn't have timer controls, and we couldn't pause or resume the stream.

Also, for counting the right `Duration` with the `Stream.periodic` we create another stream with and with the `take` method we select the desired duration

In summary:
1. create the `Stream.periodic()` that we call `initStream`
2. create another stream that takes only `Duration` seconds of the `initStream` with the `take` method, we call this one `timeStream`
3. we listen to the `timeStream` and for every event we update the text