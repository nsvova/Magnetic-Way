using UnityEngine;
using System.Collections;

public class PlayerMovement : MonoBehaviour {

    Vector3 MousePos;

    void Update()
    {
        MousePos = Input.mousePosition;

    }
}
