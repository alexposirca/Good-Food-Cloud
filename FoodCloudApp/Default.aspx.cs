using Microsoft.AspNetCore.WebUtilities;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FoodCloudApp
{
    public partial class _Default : Page {
        static string subscriptionKey = "09c1376a55e043e78d71332bdfdcfdfb";
        static string endpoint = "https://foodcloudapp.cognitiveservices.azure.com/";
        private const string READ_TEXT_URL_IMAGE = "https://intelligentkioskstore.blob.core.windows.net/visionapi/suggestedphotos/3.png";
        private const string DETECT_URL_IMAGE = "https://moderatorsampleimages.blob.core.windows.net/samples/sample9.png";
        private const string DETECT_LOCAL_IMAGE = @"apple.png";
        ArrayList ingredientsForReceipe = new ArrayList();
        protected void Page_Load(object sender, EventArgs e) {

        }

        public void UploadClick(object sender, EventArgs e)
        {
            if (ImageFile.FileName != "")
            {
                getObjectDetailsImageUpload(ImageFile);
            } else
            {
                ShowToastInfo("Please choose a image first!");
            }
            return;
        }

        public void ShowToastInfo(String message)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallMyFunction", string.Format("toastr.info('{0}');", message), true);
        }

        public void FileUrlClick(object sender, EventArgs e)
        {
            if (ImageUrl.Value != "")
            {
                getObjectDetails();
            } else
            {
                ShowToastInfo("Please insert a URL first!");
            }
            return;
        }

        public void GetReceipes(string ingredients)
        {
            var responseData = "";
            using (var client = new HttpClient())
            {
                var baseAddress = "https://api.spoonacular.com/";
                var queryParams = new Dictionary<string, string>()
                {
                    { "ingredients", ingredients },
                    { "number", "6" },
                    { "apiKey", "48459edeaadf4a27a8d1e5bc8f0796a4" }
                };
                var url = QueryHelpers.AddQueryString(baseAddress + "recipes/findByIngredients", queryParams);
                var responseTask = client.GetAsync(url);

                responseTask.Wait();

                var result = responseTask.Result;
                if (result.IsSuccessStatusCode)
                {
                    responseData = result.Content.ReadAsStringAsync().Result;
                    dynamic dynamicJson = JsonConvert.DeserializeObject(responseData.ToString());
                    receipeList.DataSource = dynamicJson;
                    receipeList.DataBind();
                }
                else {
                    receipeList.DataSource = null;
                    receipeList.DataBind();
                }

            }
        }

        public void getObjectDetails()
        {
            var client = new HttpClient();
            var responseData = "";

            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", subscriptionKey);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            var data = new
            {
                url = ImageUrl.Value
            };
            var json = JsonConvert.SerializeObject(data);
            var stringContent = new StringContent(json, System.Text.Encoding.UTF8, "application/json");

            var result = client.PostAsync(endpoint + "vision/v3.0/detect", stringContent).Result;

            if (result.IsSuccessStatusCode)
            {
                responseData = result.Content.ReadAsStringAsync().Result;
                dynamic dynamicJson = JsonConvert.DeserializeObject(responseData.ToString());

                foreach (var receipe in dynamicJson["objects"])
                {
                    var receipeElement = receipe["object"];
                    if (ingredientsForReceipe.Contains(receipeElement))
                    {
                        continue;
                    }
                    ingredientsForReceipe.Add(receipeElement);
                }
                labelReceipes.Visible = true; 
                labelIngredients.Visible = true;
                ingredientsList.DataSource = ingredientsForReceipe;
                ingredientsList.DataBind();
          
                GetReceipes(String.Join(",+", ingredientsForReceipe.ToArray()));
            }
            else {
                ingredientsList.DataSource = null;
                ingredientsList.DataBind();
            }

        }

        public void getObjectDetailsImageUpload(FileUpload localImage)
        {
            var client = new HttpClient();
            var responseData = "";

            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", subscriptionKey);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/octet-stream"));

            var content = new ByteArrayContent(localImage.FileBytes);
            content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");

            var result = client.PostAsync(endpoint + "vision/v3.0/detect", content).Result;

            if (result.IsSuccessStatusCode)
            {
                responseData = result.Content.ReadAsStringAsync().Result;
                dynamic dynamicJson = JsonConvert.DeserializeObject(responseData.ToString());

                foreach (var receipe in dynamicJson["objects"]) {
                    var receipeElement = receipe["object"];
                    if (ingredientsForReceipe.Contains(receipeElement)) {
                        continue;
                    }
                    ingredientsForReceipe.Add(receipeElement);
                }
                labelReceipes.Visible = true;
                labelIngredients.Visible = true;
                ingredientsList.DataSource = ingredientsForReceipe;
                ingredientsList.DataBind();

                GetReceipes(String.Join(",+", ingredientsForReceipe.ToArray()));
            }
            else {
                ingredientsList.DataSource = null;
                ingredientsList.DataBind();
            }
        }

        public object GetReceipeDetails(string receipeId)
        {
            var responseData = "";
            dynamic dynamicJson = null;
            using (var client = new HttpClient())
            {
                var baseAddress = "https://api.spoonacular.com/";
                var queryParams = new Dictionary<string, string>()
                {
                    { "includeNutrition", "true" },
                    { "apiKey", "48459edeaadf4a27a8d1e5bc8f0796a4" }
                };
                var url = QueryHelpers.AddQueryString(baseAddress + "recipes/" + receipeId + "/information", queryParams);
                var responseTask = client.GetAsync(url);

                responseTask.Wait();

                var result = responseTask.Result;
                if (result.IsSuccessStatusCode) {
                    responseData = result.Content.ReadAsStringAsync().Result;
                    dynamicJson = JsonConvert.DeserializeObject(responseData.ToString());
                }
                else {
                     dynamicJson = null;
                }   

             }
            return dynamicJson;

        }

        public object GetNutritents(object items)
        {
            dynamic jo = JsonConvert.SerializeObject(items);
            dynamic deserializedItem = JObject.Parse(jo);
            var nutrients = deserializedItem["nutrients"];
            Console.WriteLine(nutrients);
            return nutrients;
        }

        public object GetMeasure(object items)
        {
            dynamic jo = JsonConvert.SerializeObject(items);
            dynamic deserializedItem = JObject.Parse(jo);
            var metric = deserializedItem["metric"];

            var metricList = new ArrayList();
            metricList.Add(metric);

            return metricList;
        }

        public void ReceipeDetailsHandler(Object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;

            var receipeDetails = this.GetReceipeDetails(button.CommandArgument);

            var receipeDetailsList = new ArrayList();
            receipeDetailsList.Add(receipeDetails);
            ListDetails.DataSource = receipeDetailsList;
            ListDetails.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal();", true);
        }
    }
}