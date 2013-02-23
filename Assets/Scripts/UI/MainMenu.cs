/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Paradox source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;
using System.Collections;

public class MainMenu : MonoBehaviour
{
	private const int MAIN = 0;
	private const int ENDLESS = 1;
	private const int ARCADE = 2;
	private const int OPTIONS = 3;
	
	private int screen = MAIN;
	
	public void Start()
	{
		Lang.DetectLang();
	}
	
	public void Update ()
	{
	
	}
	
	public void OnGUI ()
	{
		GUI.Label (new Rect (470, 50, 100, 60), Lang.GetString("game.title"));
		
		if(screen.Equals(MAIN)){
			MainGUI();
		} else if (screen.Equals(ENDLESS)) {
			EndlessGUI();
		} else if (screen.Equals(ARCADE)) {
			ArcadeGUI();
		} else if (screen.Equals(OPTIONS)) {
			OptionsGUI();
		}
	}
	
	private void MainGUI()
	{
		if (GUI.Button (new Rect (440, 200, 100, 30), Lang.GetString("mode.endless"))) {
			screen = ENDLESS;
		}
		
		if (GUI.Button (new Rect (440, 250, 100, 30), Lang.GetString("mode.arcade"))) {
			screen = ARCADE;
		}
		
		if (GUI.Button (new Rect (440, 300, 100, 30), Lang.GetString("mode.puzzle"))) {

		}
		
		if (GUI.Button (new Rect (440, 350, 100, 30), Lang.GetString("mode.chronology"))) {
			
		}
		
		if (GUI.Button (new Rect (440, 450, 100, 30), Lang.GetString("mode.options"))) {
			screen = OPTIONS;
		}
	}
	
	private void EndlessGUI()
	{
		if (GUI.Button (new Rect (440, 200, 100, 30), Lang.GetString("mode.endless.relativistic"))) {
			Application.LoadLevel("Relativistic");
		}
		
		if (GUI.Button (new Rect (440, 250, 100, 30), Lang.GetString("mode.endless.universal"))) {
			Application.LoadLevel("Universal");
		}
		
		if (GUI.Button (new Rect (440, 350, 100, 30), Lang.GetString("mode.back"))) {
			screen = MAIN;
		}
	}
	
	private void ArcadeGUI()
	{
		if (GUI.Button (new Rect (150, 200, 100, 100), "1")) {
			LevelConfigurator.selectedLevel = "arcade_w1l1";
			Application.LoadLevel("Arcade");
		}
		
		if (GUI.Button (new Rect (300, 200, 100, 100), "2")) {
			LevelConfigurator.selectedLevel = "arcade_w1l2";
			Application.LoadLevel("Arcade");
		}
		
		if (GUI.Button (new Rect (450, 200, 100, 100), "3")) {
			LevelConfigurator.selectedLevel = "arcade_w1l3";
			Application.LoadLevel("Arcade");
		}
		
		if (GUI.Button (new Rect (600, 200, 100, 100), "4")) {
			LevelConfigurator.selectedLevel = "arcade_w1l4";
			Application.LoadLevel("Arcade");
		}
		
		if (GUI.Button (new Rect (750, 200, 100, 100), "5")) {
			LevelConfigurator.selectedLevel = "arcade_w1l5";
			Application.LoadLevel("Arcade");
		}
		
		if (GUI.Button (new Rect (440, 400, 100, 30), Lang.GetString("mode.back"))) {
			screen = MAIN;
		}
	}
	
	private void OptionsGUI()
	{
		if (GUI.Button (new Rect (440, 350, 100, 30), Lang.GetString("mode.back"))) {
			screen = MAIN;
		}
	}
}
