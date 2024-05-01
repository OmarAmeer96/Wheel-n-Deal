package com.graduationproject.controllers;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.services.impl.CodeService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@Data
@RequiredArgsConstructor
@RequestMapping("api/v1/user")
public class CodeController {
    private final CodeService codeService;

    @PostMapping("/generate-code/{orderId}")
    public CustomResponse generateCode(@PathVariable Integer orderId){
       return codeService.generateCode(orderId);
    }
    /*
    @GetMapping("getSenderCode/{orderId}")
    public CustomResponse getSenderCode(@PathVariable Integer orderId){
        return codeService.getSenderCode(orderId);
    }
    */
    @GetMapping("getReceiverCode/{orderId}")
    public CustomResponse getReceiverCode(@PathVariable Integer orderId){
        return codeService.getReceiverCode(orderId);
    }

    @GetMapping("getFailuerCode/{orderId}")
    public CustomResponse getFailuerCode(@PathVariable Integer orderId){
        return codeService.getSenderCode(orderId);
    }

    @PostMapping("/check-sender-code/{orderId}/{enteredCode}")
    public CustomResponse checkSenderCode(@PathVariable Integer orderId, @PathVariable String enteredCode) {
        return codeService.checkSenderCode(orderId,enteredCode);
    }
    @PostMapping("/check-receiver-code/{orderId}/{enteredCode}")
    public  CustomResponse checkReceiverCode(@PathVariable Integer orderId,@PathVariable String enteredCode) {
        return codeService.checkReceiverCode(orderId,enteredCode);
    }

    @PostMapping("/checkFailuerCode/{orderId}/{enteredCode}")
    public  CustomResponse checkFailuerCode(@PathVariable Integer orderId,@PathVariable String enteredCode) {
        return codeService.checkFailureCode(orderId,enteredCode);
    }
}
