﻿#pragma once
#include "NimForUE.h"
//Notice this bindings needs to be here because otherwise would be a cycle between Editor and NimForUEBindings
class DLLEXPORT ReinstanceBindings {
public:
	static void ReinstanceNueTypes(FString NueModule, FNimHotReload* NimHotReload, FString NimError);
};