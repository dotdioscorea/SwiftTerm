import Testing
@testable import SwiftTerm

struct BufferViewportResizeTests {
    @Test func readingHistoryKeepsItsTopLineWhenRowsGrowAndShrink() {
        let (terminal, delegate) = TerminalTestHarness.makeTerminal(cols: 80, rows: 15, scrollback: 1000)
        _ = delegate
        for index in 0..<100 {
            terminal.feed(text: "Agent update \(index)\r\n")
        }
        terminal.setViewYDisp(30)
        let firstLine = TerminalTestHarness.visibleLinesText(buffer: terminal.buffer, terminal: terminal).first
        for rows in [24, 10, 15] {
            terminal.resize(cols: 80, rows: rows)
            #expect(terminal.buffer.yDisp == 30)
            #expect(TerminalTestHarness.visibleLinesText(buffer: terminal.buffer, terminal: terminal).first == firstLine)
        }
    }

    @Test func liveViewportStillFollowsTheCursorWhenRowsGrowAndShrink() {
        let (terminal, delegate) = TerminalTestHarness.makeTerminal(cols: 80, rows: 15, scrollback: 1000)
        _ = delegate
        for index in 0..<100 {
            terminal.feed(text: "Agent update \(index)\r\n")
        }
        for rows in [24, 10, 15] {
            terminal.resize(cols: 80, rows: rows)
            #expect(terminal.buffer.yDisp == terminal.buffer.yBase)
            #expect(terminal.buffer.yBase + terminal.buffer.y == 100)
        }
    }
}
