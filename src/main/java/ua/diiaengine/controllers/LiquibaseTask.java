package ua.diiaengine.controllers;

import javafx.concurrent.Task;

public class LiquibaseTask extends Task<Void> {
    private final int counter;

    public LiquibaseTask(int counter) {
        this.counter = counter;
    }

    @Override
    protected Void call() throws Exception {
        for (int i = 0; i < counter; i++) {
            updateProgress(i, counter);
        }
        return null;
    }
}
