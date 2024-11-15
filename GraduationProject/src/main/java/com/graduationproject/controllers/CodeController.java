package com.graduationproject.controllers;

import com.graduationproject.services.impl.CodeService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Data
@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/user")
public class CodeController {

    private final CodeService codeService;

    @PostMapping("generate-code/{orderId}")
    public void generateCode(@PathVariable Integer orderId){
        codeService.generateCode(orderId);
    }

    @GetMapping("getSenderCode/{orderId}")
    public ResponseEntity<?> getSenderCode(@PathVariable Integer orderId){
        return codeService.getSenderCode(orderId);
    }

    @GetMapping("getReceiverCode/{orderId}")
    public ResponseEntity<?> getReceiverCode(@PathVariable Integer orderId){
        return codeService.getReceiverCode(orderId);
    }

    @GetMapping("getFailuerCode/{orderId}")
    public ResponseEntity<?> getFailuerCode(@PathVariable Integer orderId){
        return codeService.getSenderCode(orderId);
    }

    @PostMapping("check-sender-code/{orderId}/{enteredCode}")
    public ResponseEntity<?> checkSenderCode(@PathVariable Integer orderId, @PathVariable String enteredCode) {
        return codeService.checkSenderCode(orderId,enteredCode);
    }

    @PostMapping("check-receiver-code/{orderId}/{enteredCode}")
    public  ResponseEntity<?> checkReceiverCode(@PathVariable Integer orderId,@PathVariable String enteredCode) {
        return codeService.checkReceiverCode(orderId,enteredCode);
    }

    @PostMapping("checkFailuerCode/{orderId}/{enteredCode}")
    public  ResponseEntity<?> checkFailuerCode(@PathVariable Integer orderId,@PathVariable String enteredCode) {
        return codeService.checkFailureCode(orderId,enteredCode);
    }

}
