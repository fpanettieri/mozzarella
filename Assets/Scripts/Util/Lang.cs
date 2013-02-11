/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Paradox source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;
using System.Collections.Generic;

public class Lang
{
	private static List<string> supported;
	private static Dictionary<string, string> dict;
	
	public static void UpdateSupportedLangs()
	{
		TextAsset lang = Resources.Load("Lang/supported") as TextAsset;
		supported = new List<string>(lang.text.Trim().Split('\n'));
		for(int i = 0; i < supported.Count; i++){
			supported[i] = supported[i].Trim();
			Debug.Log("Supported language: " + supported[i]);
		}
	}
	
	public static void DetectLang()
	{
		if(supported == null){ UpdateSupportedLangs(); }
		
		if(PlayerPrefs.HasKey("language")){
			string configuredLang = PlayerPrefs.GetString("language");
			if(supported.Contains(configuredLang)){
				Load(configuredLang);
				return;
				
			} else {
				Debug.LogWarning("This is awkward. Unsupported configured language: " + configuredLang);
				PlayerPrefs.DeleteKey("language");
				PlayerPrefs.Save();
			}
		}
		string defaultLang = supported[0];
		SystemLanguage sysLang = Application.systemLanguage;
		if(sysLang.Equals(SystemLanguage.Spanish)){
			 defaultLang = "es_LA";
			
		} else if(sysLang.Equals(SystemLanguage.Portuguese)){
			defaultLang = "pt_BR";
		}
		PlayerPrefs.SetString("language", defaultLang);
		PlayerPrefs.Save();
		Load(defaultLang);
	} 
	
	public static void Load(string locale)
	{
		if(supported == null){ UpdateSupportedLangs(); }
		
		TextAsset lang;
		if(supported.Contains(locale)){
			Debug.Log("Loading language " + locale);
			lang = Resources.Load("Lang/" + locale) as TextAsset;
				
		} else {
			Debug.LogWarning("Unsupported language: " + locale);
			lang = Resources.Load("Lang/en_US") as TextAsset;
		}
			
		dict = new Dictionary<string, string>();
		
		string[] lines = lang.text.Trim().Split('\n');
		foreach(string line in lines){
			int pos = line.IndexOf('=');
			if(pos > 1){
				string[] kv = line.Split('=');
				dict[kv[0].Trim()] = kv[1].Trim();
			} else {
				Debug.LogWarning("Malformed line: " + line);
			}
		}
	}
	
	public static string GetString(string key)
	{
		if(dict.ContainsKey(key)){
			return dict[key];
		} else {			
			Debug.LogWarning("Key not found: " + key);
			return key + ": not found";
		}
	}
}
