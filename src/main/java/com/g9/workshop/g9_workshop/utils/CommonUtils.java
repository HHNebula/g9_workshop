package com.g9.workshop.g9_workshop.utils;

import java.util.UUID;

import org.springframework.stereotype.Component;

@Component
public class CommonUtils {

    public String getUniqueSequence() {

        UUID uuid = UUID.randomUUID();
        return uuid.toString();

    }

}
