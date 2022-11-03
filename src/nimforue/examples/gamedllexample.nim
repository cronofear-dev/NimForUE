include ../unreal/prelude
import ../../buildscripts/[buildscripts, nimforueconfig]

import std/[os, dynlib, strformat, options]

type 
  GameExposedFn = proc (): cint {.gcsafe, stdcall.}
  GetUEEmitterFn = proc (): UEEmitterPtr {.gcsafe, stdcall.}

let config = getNimForUEConfig()
let dllDir = config.pluginDir / "Binaries" / "nim" / "ue"

#Need to add the dir to the library


uClass AGameDllTest of AActor:
  (BlueprintType)
  ufuncs(CallInEditor):
    proc loadGameDll() = 
      try:
        let gameDllPath = getLastLibPath(dllDir, "game").get()
        UE_Log &"config: {config}"
        UE_Log &"Loading game dll: {dllDir}"
        UE_Log &"does the lib exists {fileExists(gameDllPath)}"
        UE_Log gameDllPath
        let lib = loadLib gameDllPath
        let getUEEmitter = cast[GetUEEmitterFn](lib.symAddr("getUEEmitter"))
        if not getUEEmitter.isNil():
          let result = getUEEmitter()
          if not result.isNil():
            UE_Log &"UEEmitter: {result}"
          else:
            UE_Log "UEEmitter is nil"
        else:
          UE_Log "gameExposedFn is nil"
      except:
        UE_Error getCurrentExceptionMsg()

        