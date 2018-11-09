using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cam : MonoBehaviour {
    public GameObject gotoplayer;
    public GameObject lookat;
    // Use this for initialization
    void Start () {
		
	}
	
	// Update is called once per frame
	void LateUpdate () {
        transform.position = Vector3.Lerp(transform.position, gotoplayer.transform.position, Time.deltaTime*2);
        transform.LookAt(lookat.transform);
	}
}
