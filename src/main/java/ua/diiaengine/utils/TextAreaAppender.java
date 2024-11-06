package ua.diiaengine.utils;

import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.AppenderBase;
import javafx.application.Platform;
import javafx.scene.control.TextArea;
import lombok.Setter;

public class TextAreaAppender extends AppenderBase<ILoggingEvent> {
    @Setter
    private static TextArea logArea;

    @Override
    protected void append(ILoggingEvent event) {
        if (logArea != null) {
            String message = event.getFormattedMessage();
            Platform.runLater(() -> logArea.appendText(message + "\n"));
        }
    }
}

