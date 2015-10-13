using UnityEngine;
using System.Collections;

public class DeathWall : MonoBehaviour {

	void OnTriggerEnter2D(Collider2D other)
    {
        if(other.gameObject.tag == "Player")
        {
            Debug.Log("You Are dead!");//TODO UI
            Application.LoadLevel("");//TODO UI
        }
    }
}
