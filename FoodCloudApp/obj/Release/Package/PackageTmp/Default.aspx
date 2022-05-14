<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FoodCloudApp._Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function showModal() {
            $("#receipeModal").modal('show');
        }

        function displayToastNotification(type, message) {
            console.log(type, message);
            toastr.info(message);
        }
    </script>
     <div class="home-description">
       <p class="description"> Find out what to cook only with the ingredients available from your kitchen! </p>
       <p class="description"> Easy and simple! </p>
       <img src="https://i.pinimg.com/originals/a6/93/de/a693deeb3c809a0786e98b7f19421829.jpg" alt="logo" class="description-img">

    </div>
    <div id="toast" aria-live="polite" aria-atomic="true">
      <div class="toast" style="position: absolute; top: 0; right: 0;">
        <div class="toast-header">
          <strong class="mr-auto">Information</strong>
          <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="toast-body">
          <span id="toastContent"></span>
        </div>
      </div>
    </div>

    <div class="modal fade bd-example-modal-lg" id="receipeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Details for receipe</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="details d-flex flex-column align-items-center">
                        <asp:ListView
                            ID="ListDetails"
                            runat="server"
                        >
                            <EmptyDataTemplate>
                                <span>No details for this receipe. Sorry.</span>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <img
                                    class="rounded"
                                    src="<%# Eval("image") %>"
                                    width="400"
                                />
                                <h3 class="my-3">
                                    <%# Eval("title") %>
                                </h3>
                                <div class="d-flex flex-row mb-3 w-100 justify-content-around ">
                                    <div class="d-flex flex-row align-items-center">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-alarm" viewBox="0 0 16 16">
                                            <path d="M8.5 5.5a.5.5 0 0 0-1 0v3.362l-1.429 2.38a.5.5 0 1 0 .858.515l1.5-2.5A.5.5 0 0 0 8.5 9V5.5z"/>
                                            <path d="M6.5 0a.5.5 0 0 0 0 1H7v1.07a7.001 7.001 0 0 0-3.273 12.474l-.602.602a.5.5 0 0 0 .707.708l.746-.746A6.97 6.97 0 0 0 8 16a6.97 6.97 0 0 0 3.422-.892l.746.746a.5.5 0 0 0 .707-.708l-.601-.602A7.001 7.001 0 0 0 9 2.07V1h.5a.5.5 0 0 0 0-1h-3zm1.038 3.018a6.093 6.093 0 0 1 .924 0 6 6 0 1 1-.924 0zM0 3.5c0 .753.333 1.429.86 1.887A8.035 8.035 0 0 1 4.387 1.86 2.5 2.5 0 0 0 0 3.5zM13.5 1c-.753 0-1.429.333-1.887.86a8.035 8.035 0 0 1 3.527 3.527A2.5 2.5 0 0 0 13.5 1z"/>
                                        </svg>
                                        <span>
                                            <%# Eval("readyInMinutes") %> min
                                        </span>
                                    </div>
                                    <div class="d-flex flex-row mx-4 align-items-center">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cash" viewBox="0 0 16 16">
                                          <path d="M8 10a2 2 0 1 0 0-4 2 2 0 0 0 0 4z"/>
                                          <path d="M0 4a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H1a1 1 0 0 1-1-1V4zm3 0a2 2 0 0 1-2 2v4a2 2 0 0 1 2 2h10a2 2 0 0 1 2-2V6a2 2 0 0 1-2-2H3z"/>
                                        </svg>
                                        <span>
                                            $<%# Decimal.Round(Decimal.Parse(Eval("pricePerServing", ""))/100, 2) %>/serving
                                        </span>
                                    </div>
                                    <div class="d-flex flex-row align-items-center">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-people" viewBox="0 0 16 16">
                                          <path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1h8zm-7.978-1A.261.261 0 0 1 7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002a.274.274 0 0 1-.014.002H7.022zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0zM6.936 9.28a5.88 5.88 0 0 0-1.23-.247A7.35 7.35 0 0 0 5 9c-4 0-5 3-5 4 0 .667.333 1 1 1h4.216A2.238 2.238 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816zM4.92 10A5.493 5.493 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275zM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0zm3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4z"/>
                                        </svg>
                                        <span>
                                             <%# Eval("servings") %> servings
                                        </span>
                                    </div>
                                </div>
                                <div class="">
                                    <h4 class="mb-0">Summary</h4>
                                    <hr class="mt-2 mb-4"/>
                                    <div class="summary">
                                        <%# Eval("summary") %>
                                    </div>
                                </div>
                                <br />
                                <div class="w-100 mt-2">
                                    <h4 class="mb-0">Ingredients</h4>
                                    <hr class="mt-2 mb-4"/>
                                    <asp:ListView
                                        ID="FullIngredientsList"
                                        runat="server"
                                        DataSource='<%# Eval("extendedIngredients") %>'
                                    >
                                        <EmptyDataTemplate>
                                            <span>No ingredients were found</span>
                                        </EmptyDataTemplate>
                                        <ItemTemplate>
                                            <div class="row ingredient mb-2">
                                                <div class="col d-flex align-items-center">
                                                    <div class="position-relative" style="height: 50px; width: 50px">
                                                        <img
                                                            class="img-fluid"
                                                            src="https://spoonacular.com/cdn/ingredients_100x100/<%# Eval("image") %>"
                                                        />
                                                    </div>
                                                    <span class="mx-3">
                                                        <asp:Repeater
                                                            ID="Repeater1"
                                                            runat="server"
                                                            DataSource='<%# GetMeasure(Eval("measures")) %>'
                                                        >
                                                            <ItemTemplate>
                                                                <%# Eval("amount") %>
                                                                <%# Eval("unitShort") %>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </span>
                                                    <span>
                                                        <%# Eval("name") %>
                                                    </span>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>
                                <div class="w-100 mt-2">
                                    <h4 class="mb-0">Nutrients</h4>
                                    <hr class="mt-2 mb-4"/>

                                    <div class="nutrients">
                                        <asp:GridView
                                            ID="GridView1"
                                            runat="server"
                                            DataSource='<%# GetNutritents(Eval("nutrition")) %>'
                                            AutoGenerateColumns="false"
                                        >
                                            <Columns>
                                                <asp:BoundField DataField="name" HeaderText="Name"/>
                                                <asp:BoundField DataField="amount" HeaderText="Quatity"/>
                                                <asp:BoundField DataField="unit" HeaderText="Unit"/>
                                                <asp:BoundField DataField="percentOfDailyNeeds" HeaderText="Daily Need (%)"/>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    <asp:UpdatePanel class="uploadImage" ID="UpdatePanel" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="btnUploadFile" /> 
        </Triggers>
        <ContentTemplate>
            <label id="lblChooseFile">Choose a food image from your computer.</label>
            <div>
                <asp:FileUpload ID="ImageFile" runat="server"/>
                <asp:Button ID="btnUploadFile" runat="server" Text="Upload Image" onclick="UploadClick" />
            </div>
            <br />
             <label class="boldStyle">-OR-</label>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="uploadImage">
         <label id="lblInsertURL">Add the URL of a food image.</label>
        <div>
            <input class="inpImageUrl" ID="ImageUrl" type="text" runat="server" />
            <asp:Button ID="btnFileURL" runat="server" onclick="FileUrlClick" Text="Upload Image" />
        </div>
       
    </div>
 
    <br />
    <asp:Label ID="labelIngredients" runat="server" Visible="false">
        <h2>Ingredients for receipe</h2>
    </asp:Label>
    <div class="ingredients d-flex flex-row">
        <asp:ListView
            ID="ingredientsList"
            runat="server"
        >
            <EmptyDataTemplate>
                <span>No ingredients were found</span>
            </EmptyDataTemplate>
            <ItemTemplate>
                <div class="ingredient">
                    <span class="badge badge-dark mr-2 p-2">
                        <%# Container.DataItem %>
                    </span>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>

    <br />
    <br />
    <asp:Label ID="labelReceipes" runat="server" Visible="false">
        <h2>Receipes</h2>
    </asp:Label>
    <div class="recipes">
        <div class="card-deck justify-content-center">
            <asp:ListView
                ID="receipeList"
                runat="server"
            >
                <EmptyDataTemplate>
                    <span>No data was returned.</span>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="mt-3 card" style="max-width: 200px; min-width: 200px">
                        <asp:LinkButton
                            runat="server"
                            CommandArgument='<%#Eval("id")%>'
                            onclick="ReceipeDetailsHandler"
                        >
                            <img
                                class="card-img-top"
                                src="<%# Eval("image") %>"
                                width="200"
                            />
                            <div class="card-body">
                                <h5><%# Eval("title") %></h5>
                            </div>
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
</asp:Content>
