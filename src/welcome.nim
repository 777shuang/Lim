import nimx/window
import nimx/button
import nimx/text_field
import nimx/font
import nimx/formatted_text

proc welcome*() {.inline.} =
    let wnd = newWindow(newRect(50, 50, 512, 512))

    let label = newLabel(newRect(20, 20, 460, 60))
    label.text = "Welcome to Lim"
    label.formattedText.setFontInRange(0, label.text.len, systemFontOfSize(40))
    wnd.addSubview(label)

    let newProjectButton = newButton(newRect(20, 100, 60, 60))
    newProjectButton.title = "+"
    wnd.addSubview(newProjectButton)

    let newProjectLabel = newLabel(newRect(80, 100, 400, 60))
    newProjectLabel.text = "New Project"
    newProjectLabel.formattedText.setFontInRange(0, newProjectLabel.text.len, systemFontOfSize(40))
    wnd.addSubview(newProjectLabel)

    let openProjectButton = newButton(newRect(20, 180, 60, 60))
    openProjectButton.title = "..."
    wnd.addSubview(openProjectButton)

    let openProjectLabel = newLabel(newRect(80, 180, 400, 60))
    openProjectLabel.text = "Open Project"
    openProjectLabel.formattedText.setFontInRange(0, openProjectLabel.text.len, systemFontOfSize(40))
    wnd.addSubview(openProjectLabel)