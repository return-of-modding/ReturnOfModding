# Class: CScriptRef

Class representing a game maker script reference.

Can be called by having an instance and doing `someScriptRefInstance(self, other, someExtraArg)`.

Atleast 2 args 'self' and 'other' game maker instances / structs need to be passed when calling the script.

lua nil can also be passed if needed for those two args.

Can also be hooked with a pre / post script hook. The `gml_Script_` prefix may need to be removed for the hook to work. Use the `script_name` field to retrieve the name.

